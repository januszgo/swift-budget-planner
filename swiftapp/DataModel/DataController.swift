//
//  DataController.swift
//  swiftapp
//
//  Created by user230926 on 1/1/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Data loading error \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        }catch{
            print("Data saving error")
        }
    }
    
    func addIncome(name:String, value:Double, context:NSManagedObjectContext) {
        let income = Income(context: context)
        income.id = UUID()
        income.name = name
        income.value = value
        save(context:context)
    }
    
    func editIncome(income:Income,name:String, value:Double, context:NSManagedObjectContext) {
        income.name = name
        income.value = value
        save(context:context)
    }
    
    func addOutcome(name:String, value:Double, context:NSManagedObjectContext) {
        let income = Income(context: context)
        income.id = UUID()
        income.name = name
        income.value = value
        save(context:context)
    }
    
    func editOutcome(income:Income,name:String, value:Double, context:NSManagedObjectContext) {
        income.name = name
        income.value = value
        save(context:context)
    }
    
}
