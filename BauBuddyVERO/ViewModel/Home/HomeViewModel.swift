//
//  HomeViewModel.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private let repository: HomeRepository
    var tasks = BehaviorSubject<[Tasks]>(value: [])
    var isLoading = BehaviorRelay(value: false)
    var error = BehaviorSubject<NetworkError?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(repository: HomeRepository) {
        self.repository = repository
        bindTasks()
        bindLoading()
        bindErrors()
    }
    
    func bindTasks() {
        repository.tasksListObservable
            .subscribe(onNext: { [weak self] tasks in
                self?.tasks.onNext(tasks)
            })
            .disposed(by: disposeBag)
    }
    
    func bindLoading() {
        repository.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)
    }
    
    func bindErrors() {
        repository.errorObservable
            .subscribe(onNext: { [weak self] error in
                self?.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    func loginAndFetchTasks() {
        repository.loginAndFetchTasks()
    }
    
    func retrieveTasksFromLocalDatabase() {
        repository.retrieveTasksFromLocalDatabase()
            .subscribe(onNext: { [weak self] tasks in
                self?.tasks.onNext(tasks)
            }, onError: { [weak self] error in
                if let networkError = error as? NetworkError {
                    self?.error.onNext(networkError)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func searchTasks(query: String) {
        if query.isEmpty {
            retrieveTasksFromLocalDatabase()
        } else {
            repository.searchTasks(query: query)
                .subscribe(onNext: { [weak self] tasks in
                    self?.tasks.onNext(tasks)
                }, onError: { [weak self] error in
                    if let networkError = error as? NetworkError {
                        self?.error.onNext(networkError)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}

