//
//  TaskModel.swift
//  BauBuddyVERO
//
//  Created by Murat on 7.11.2023.
//

import Foundation

// MARK: - Tasks
struct Tasks: Codable {
    let task, title, description, sort: String
    let wageType: String
    let businessUnitKey: BusinessUnit?
    let businessUnit: BusinessUnit
    let parentTaskID: ParentTaskID
    let preplanningBoardQuickSelect: String?
    let colorCode: String
    let workingTime: Int?
    let isAvailableInTimeTrackingKioskMode: Bool

    enum CodingKeys: String, CodingKey {
        case task, title, description, sort, wageType
        case businessUnitKey = "BusinessUnitKey"
        case businessUnit, parentTaskID, preplanningBoardQuickSelect, colorCode, workingTime, isAvailableInTimeTrackingKioskMode
    }
}

enum BusinessUnit: String, Codable {
    case empty = ""
    case gerüstbau = "Gerüstbau"
}

enum ParentTaskID: String, Codable {
    case empty = ""
    case the10Aufbau = "10 Aufbau"
    case the60Transportbühnen = "60 Transportbühnen"
}


