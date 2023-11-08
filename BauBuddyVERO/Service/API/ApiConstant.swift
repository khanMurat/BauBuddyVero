//
//  ApiConstant.swift
//  BauBuddyVERO
//
//  Created by Murat on 7.11.2023.
//

import Foundation

struct API {
    static let baseURL = "https://api.baubuddy.de"
    
    struct Path {
        static let login = "/index.php/login"
        static let tasksSelect = "/dev/index.php/v1/tasks/select"
    }
    
    struct Credentials {
        static let username = "365"
        static let password = "1"
    }
    
    struct Headers {
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let applicationJSON = "application/json"
        static let basicAuthValue = "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz"
    }
}

struct Network {
    static let networkError: String = "Network error"
    static let invalidEndpoint: String = "Error is caused because of invalid endpoint"
    static let invalidURL: String = "Error is caused because of invalid URL"
    static let invalidBodyParameter: String = "Error is caused because of body parameters"
    static let invalidResponse: String = "Error is caused because of invalid network response"
    static let invalidData: String = "Error is caused because of invalid data"
    static let noNetwork: String = "Not connected to Network or network connection lost"
}
