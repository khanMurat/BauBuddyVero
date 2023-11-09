//
//  HomeRepository.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeRepository {
    var isLoading = BehaviorRelay(value: false)
    var tasksListObservable = BehaviorSubject<[Tasks]>(value: [])
    var errorObservable = BehaviorSubject<NetworkError?>(value: nil)
    let apiService = APIService()
    private let disposeBag = DisposeBag()
        
    func loginAndFetchTasks() {
        isLoading.accept(true)
        apiService.login(username: "365", password: "1")
            .flatMapLatest { [weak self] auth -> Observable<[Tasks]> in
                self?.apiService.fetchTasks(accessToken: auth.oauth.accessToken) ?? .empty()
            }
            .subscribe(onNext: { [weak self] tasks in
                tasks.forEach { task in
                    LocalDataSource.shared.insertTask(task:task)
                }
                self?.retrieveTasksFromLocalDatabase().subscribe(onNext: { localTasks in
                    self?.tasksListObservable.onNext(localTasks)
                    self?.isLoading.accept(false)
                }).disposed(by: self?.disposeBag ?? DisposeBag())
            }, onError: { [weak self] error in
                self?.errorObservable.onNext(error as? NetworkError ?? .invalidResponse)
                self?.isLoading.accept(false)
            }).disposed(by: disposeBag)
    }
    
    func retrieveTasksFromLocalDatabase() -> Observable<[Tasks]> {
        return LocalDataSource.shared.getAllTasks()
    }

    func searchTasks(query: String) -> Observable<[Tasks]> {
        return LocalDataSource.shared.searchTasks(query: query)
    }
}

