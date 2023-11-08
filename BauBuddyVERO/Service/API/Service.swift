//
//  Service.swift
//  BauBuddyVERO
//
//  Created by Murat on 7.11.2023.
//

import Foundation
import Alamofire
import RxSwift

class APIService {

    func login(username: String, password: String) -> Observable<Auth> {
        return Observable.create { observer in
            let loginURL = API.baseURL + API.Path.login
            let credentials = [
                "username": username,
                "password": password
            ]

            AF.request(loginURL, method: .post, parameters: credentials, encoding: JSONEncoding.default, headers: [API.Headers.authorization: API.Headers.basicAuthValue, API.Headers.contentType: API.Headers.applicationJSON]).responseDecodable(of: Auth.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    observer.onNext(loginResponse)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(self.mapError(error))
                }
            }

            return Disposables.create()
        }

    func fetchTasks(accessToken: String) -> Observable<[Tasks]> {
        return Observable.create { observer in
            let tasksURL = API.baseURL + API.Path.tasksSelect
            let headers: HTTPHeaders = [
                API.Headers.authorization: "Bearer \(accessToken)"
            ]

            AF.request(tasksURL, method: .get, headers: headers).responseDecodable(of: [Tasks].self) { response in
                switch response.result {
                case .success(let tasks):
                    observer.onNext(tasks)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(self.mapError(error))
                }
            }

            return Disposables.create()
                
        }
    }
}
    private func mapError(_ error: AFError) -> NetworkError {
        if let urlError = error.underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return .noNetwork
            default:
                return .invalidResponse
            }
        } else if error.isInvalidURLError {
            return .invalidURL
        } else if error.isResponseSerializationError {
            return .invalidData
        } else if error.isResponseValidationError {
            return .invalidResponse
        } else {
            return .invalidResponse
        }
    }
}


