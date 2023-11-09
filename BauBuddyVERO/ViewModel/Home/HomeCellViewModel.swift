//
//  HomeCellViewModel.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import Foundation
import UIKit

struct HomeCellViewModel {
    var task: Tasks
    
    init(task: Tasks) {
        self.task = task
    }
    
    var taskName: String {
        return task.task
    }
    
    var titleName: String {
        return task.title
    }
    
    var descriptionName : String {
        return task.description
    }
    
    var hexColor : String {
        return task.colorCode
    }
   
}
