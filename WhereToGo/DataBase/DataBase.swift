//
//  DataBase.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class DataBase: NSObject {
    
    class func appDelegateObjcet() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    
    class func InfoInsert(text: String) -> Bool {
        
        let app = self.appDelegateObjcet()
        
        let context = app.persistentContainer.viewContext
        
        let entry = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        
        let person = NSManagedObject(entity: entry!, insertInto: context)
        
        person.setValue(text, forKey: "userName")
        do {
            try context.save()
        } catch  {
            fatalError("无法保存")
        }
        
        print("保存成功")
        
        return true
    }
    

}
