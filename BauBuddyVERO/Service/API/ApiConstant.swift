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
    static let networkError: String = "Network error occurred"
    static let invalidEndpoint: String = "Invalid endpoint error"
    static let invalidURL: String = "URL format error"
    static let invalidBodyParameter: String = "Body parameter error"
    static let invalidResponse: String = "Response error"
    static let invalidData: String = "Data format error"
    static let noNetwork: String = "No network connection"
}
