//
//  ServiceError.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import Foundation
enum NetworkError: LocalizedError {
    case invalidEndpoint
    case invalidURL
    case invalidBodyParameter
    case invalidResponse
    case invalidData
    case noNetwork
    
    var description: String {
        switch self {
        case .invalidEndpoint:
            return Network.invalidEndpoint
        case .invalidURL:
            return Network.invalidURL
        case .invalidBodyParameter:
            return Network.invalidBodyParameter
        case .invalidResponse:
            return Network.invalidResponse
        case .invalidData:
            return Network.invalidData
        case .noNetwork:
            return Network.noNetwork
        }
    }
}
