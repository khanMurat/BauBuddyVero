//
//  Constants.swift
//  BauBuddyVERO
//
//  Created by Murat on 10.11.2023.
//

import UIKit

class Constants {
    // MARK: - Cell Identifiers
    static let taskCellIdentifier = "TaskCell"

    // MARK: - Default Values
    static let defaultRowHeight: CGFloat = 120.0
    static let debounceInterval: Int = 500 // For searchField debounce in milliseconds
    static let colorViewCornerRadius: CGFloat = 10.0
    
    
    //MARK: - Storyboard ID
    
    static let mainStoryboardID = "Main"
    static let qrStoryboardID = "QRScan"
    
    //MARK: - Alert
    
    static let okeyText = "OK"
    static let successText = "Success"
    static let errorText = "Error"
}
