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
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupUI()
        bindViewModel()
        viewModel.loginAndFetchTasks()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        tableView.rowHeight = Constants.defaultRowHeight
        activityIndicator.hidesWhenStopped = true
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    //MARK: - Actions
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        viewModel.loginAndFetchTasks()
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
                if self?.refreshControl.isRefreshing ?? false {
                    self?.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                if error != nil {
                    self?.showErrorAlert(error: error!)
                    if ((self?.refreshControl.isRefreshing) != nil){
                        self?.activityIndicator.isHidden = true
                    }
                    else{
                        self?.refreshControl.endRefreshing()
                        self?.activityIndicator.isHidden = false
                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
               .observe(on: MainScheduler.instance)
               .subscribe(onNext: { [weak self] isLoading in
                   if !(self?.refreshControl.isRefreshing ?? false) {
                       self?.activityIndicator.isHidden = !isLoading
                       if isLoading {
                           self?.activityIndicator.startAnimating()
                       } else {
                           self?.activityIndicator.stopAnimating()
                       }
                   }
               })
               .disposed(by: disposeBag)
        
        let _ = searchField.rx.text.orEmpty
            .debounce(.milliseconds(Constants.debounceInterval), scheduler: MainScheduler.instance)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.taskCellIdentifier, for: indexPath) as! HomeTableViewCell
        
        cell.viewModel = HomeCellViewModel(task: taskList[indexPath.row])
        
        return cell
    }
}
