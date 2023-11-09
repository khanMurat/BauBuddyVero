//
//  TaskViewController.swift
//  BauBuddyVERO
//
//  Created by Murat on 7.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var taskList = [Tasks]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    private let repository = HomeRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupUI()
        bindViewModel()
        viewModel.loginAndFetchTasks()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        tableView.rowHeight = 100
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - ViewModel Setup & Binding
    
    private func setupViewModel() {
        viewModel = HomeViewModel(repository: repository)
    }
    
    private func bindViewModel() {
        viewModel.tasks
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] tasks in
                self?.taskList = tasks
            })
            .disposed(by: disposeBag)

        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                if error != nil {
                    self?.showErrorAlert(error: error!)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading.bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        let _ = searchField.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.searchTasks(query: query)
            }).disposed(by: disposeBag)
    }

}

//MARK: - UITableViewDelegate,UITableViewDataSource

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! HomeTableViewCell
        
        cell.viewModel = HomeCellViewModel(task: taskList[indexPath.row])
        
        return cell
    }
}
