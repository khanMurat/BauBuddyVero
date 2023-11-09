//
//  LocalDataSource.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import Foundation
import SQLite
import RxSwift

class LocalDataSource {
    
    static let shared = LocalDataSource()
    
    private var database : Connection!
    
    let tasksTable = Table("Tasks")
    let taskName = Expression<String>("task")
    let titleText = Expression<String>("title")
    let descriptionText = Expression<String>("description")
    let colorCode = Expression<String>("colorCode")
    
    
    private init() {
        
        getDatabasePath()
        
    }
    
    private func getDatabasePath(){
        
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            self.database = try Connection("\(path)/db.sqlite3")
            
            createTable()
        }catch{
            print("DEBUG : Error when database connection \(error.localizedDescription)")
        }
    }
    
    private func createTable(){
        
        do{
            let existingTables = try database.scalar("SELECT name FROM sqlite_master WHERE type='table' AND name='Foods'")
            if existingTables != nil{
                print("Table already exists")
                return
            }
        }catch{
            print("Error checking for existing table: \(error)")
        }
        
        do{
            
            try database.run(tasksTable.create { t in
                t.column(taskName)
                t.column(titleText)
                t.column(descriptionText)
                t.column(colorCode)
            })
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func insertTask(task:Tasks){
        
        let insertOrUpdate = tasksTable.insert(or: .replace,
                                               taskName <- task.task,
                                               titleText <- task.title,
                                               descriptionText <- task.description,
                                               colorCode <- task.colorCode
        )
        do{
            try database.run(insertOrUpdate)
        }catch{
            print("DEBUG : Error when insert food to table \(error.localizedDescription)")
        }
    }
    
    func getAllTasks() -> Observable<[Tasks]> {
        
        return Observable.create { observer in
            
            do{
                
                var tasks = [Tasks]()
                
                for task in try self.database.prepare(self.tasksTable){
                    
                    let task = Tasks(task: task[self.taskName], title: task[self.titleText], description: task[self.descriptionText], colorCode: task[self.colorCode])
                    tasks.append(task)
                }
                
                observer.onNext(tasks)
                observer.onCompleted()
            }catch{
                observer.onError(error)
            }
            return Disposables.create()
        }
        
    }
    
    func searchTasks(query: String) -> Observable<[Tasks]> {
        return Observable.create { observer in
            do {
                var tasks = [Tasks]()
                let queryResult = self.tasksTable.filter(self.titleText.like("%\(query)%"))
                for task in try self.database.prepare(queryResult) {
                    let task = Tasks(task: task[self.taskName], title: task[self.titleText], description: task[self.descriptionText], colorCode: task[self.colorCode])
                    tasks.append(task)
                }
                observer.onNext(tasks)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
}

