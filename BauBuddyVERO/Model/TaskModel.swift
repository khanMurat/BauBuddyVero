//
//  TaskModel.swift
//  BauBuddyVERO
//
//  Created by Murat on 7.11.2023.
//

import Foundation

// MARK: - Tasks
struct Tasks: Codable {
    let task, title, description: String
    let colorCode: String

    enum CodingKeys: String, CodingKey {
        case task, title, description
        case colorCode
    }
}



