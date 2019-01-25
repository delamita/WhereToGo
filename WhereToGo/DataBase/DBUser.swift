//
//  DBUser.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

import Foundation
import CoreData



extension DataBase{
    
    
    
    ///将新建User类的实例存储到DBUserb表中
    ///
    /// - Parameter user: 存储的User实例
    /// - Returns: 成功返回true，失败返回false
    class func createNewUser(user: User) ->  Bool{
        
        let context = self.appDelegateObjcet().persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DBUser", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(user.userName, forKey: "userName")
        newUser.setValue(user.password, forKey: "password")
        newUser.setValue(user.phoneNumber, forKey: "phoneNumber")
        newUser.setValue(user.avaImage, forKey: "avaImage")
        
        do {
            try context.save()
        } catch  {
            print("无法保存")
            return false
        }
        
        return true
        
    }
    
    
    
    
    /// 查询并在打印所有用户的用户名
    class func showAlluserName(){
        
        var users = [String]()
        var people = [NSManagedObject]()
        
        let managedObectContext = self.appDelegateObjcet().persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBUser")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                
                people = results
                
                for i in 0..<people.count{
                    users.append(people[i].value(forKey: "userName") as! String )
                }
                
                print(users)
                
            }
            
        } catch  {
            fatalError("获取失败")
        }
    }
    
    
    
    
    
    /// 通过手机号码来查询对应的用户，手机号是用户的主键
    ///
    /// - Parameter withPhoneNumber: 查询的手机号
    /// - Returns: 查询到的User类用户
    class func getUser(withPhoneNumber: String) -> User {
        
        let user = User()
        
        //  获取上下文
        let managedObectContext = self.appDelegateObjcet().persistentContainer.viewContext
        
        //  建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBUser")
        
        
        
        //  进行查询
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let result = fetchedResults {
                
                for i in 0..<result.count{
                    if result[i].value(forKey: "phoneNumber") as! String == withPhoneNumber {
                        
                        user.userName = result[i].value(forKey: "userName") as? String
                        user.password = result[i].value(forKey: "password") as? String
                        user.phoneNumber = result[i].value(forKey: "phoneNumber") as? String
                        user.avaImage = result[i].value(forKey: "avaImage") as? UIImage
                        
                        break
                    }
                }
                
            }
            
        } catch  {
            print("未找到用户")
        }
        
        
        
        return user
    }
    
    
    
    
    
    
    
}
