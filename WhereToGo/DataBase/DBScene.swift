//
//  DBScene.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension DataBase{
    

    /// 将新建的Scenek类场景存储到数据库中
    ///
    /// - Parameter scene:需要存储的新建Scene类场景
    /// - Returns: 存储成功返回true，失败返回false
    class func createNewScene(scene: Scene ) -> Bool {
        
        let context = self.appDelegateObjcet().persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DBScene", in: context)
        
        let newScene = NSManagedObject(entity: entity!, insertInto: context)
        
        newScene.setValue(scene.sceneId, forKey: "sceneId")
        newScene.setValue(scene.name, forKey: "name")
        newScene.setValue(scene.title, forKey: "title")
        newScene.setValue(scene.describe, forKey: "describe")
        newScene.setValue(scene.phone, forKey: "phone")
        newScene.setValue(scene.address, forKey: "address")
        newScene.setValue(scene.price, forKey: "price")
        newScene.setValue(scene.tags, forKey: "tags")
        newScene.setValue(scene.images, forKey: "images")
        
        do {
            try context.save()
        } catch  {
            print("无法保存")
            return false
        }
        
        return true
    }
    
    
    
    
    // 根据场景号查询场景
    class func getScene(withSceneId: String) -> Scene {
        
        let scene = Scene(sceneId: withSceneId)
        
        let managedObjectContext = self.appDelegateObjcet().persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBScene")
        
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let result = fetchedResults {
                
                for i in result{
                    
                    if i.value(forKey: "sceneId") as! String == withSceneId {
                        
                        scene.name = i.value(forKey: "name") as? String
                        scene.title = i.value(forKey: "title") as? String
                        scene.describe = i.value(forKey: "describe") as? String
                        scene.address = i.value(forKey: "address") as? String
                        scene.sceneId = i.value(forKey: "sceneId") as! String
                        scene.phone = i.value(forKey: "phone") as? String
                        scene.price = i.value(forKey: "price") as? Int
                        
                        
                        
                        scene.tags = i.value(forKey: "tags") as? [String]
                        scene.images = i.value(forKey: "images") as? [UIImage]
                        
                        
                        break
                    }
                }
                
            }
            
        } catch  {
            print("未找到场景")
        }
        
        
        return scene
    }
    
    
    
    /// 返回所有在DataBase中存储的场景
    ///
    /// - Returns: 所有的场景
    class func
        getAllSceneInDB() -> [Scene]? {
        
        var scenes = [Scene]()
        
        let managedObjectContext = self.appDelegateObjcet().persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBScene")
        
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let result = fetchedResults {
                
                for i in result {
                    
                    let scene = Scene()
                    
                    scene.name = i.value(forKey: "name") as? String
                    scene.title = i.value(forKey: "title") as? String
                    scene.describe = i.value(forKey: "describe") as? String
                    scene.address = i.value(forKey: "address") as? String
                    scene.sceneId = i.value(forKey: "sceneId") as! String
                    scene.phone = i.value(forKey: "phone") as? String
                    scene.price = i.value(forKey: "price") as? Int
                    
                    
                    
                    scene.tags = i.value(forKey: "tags") as? [String]
                    scene.images = i.value(forKey: "images") as? [UIImage]
                    
                    scenes.append(scene)
                    
                    print("添加了场景SceneId:", scene.sceneId," Name:", scene.name!)
                    
                }
                
            }
            
        } catch {
            print("一个场景都没有")
            return nil
        }
        
        
        
        return scenes
    }
    
    
    
    
    
    
    // 根据场景号删除场景
    class func deletScene(withSceneId: String) -> Bool {
        
        
        let managedObjectContext = self.appDelegateObjcet().persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBScene")
        
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let result = fetchedResults {
                
                for i in result{
                    
                    if i.value(forKey: "sceneId") as! String == withSceneId {
                        
                        print("\n将删除场景,SceneId:",i.value(forKey: "SceneId") as! String, " sceneName:", i.value(forKey:"name") as! String  )
                        
                        managedObjectContext.delete(i)
                        
                        break
                    }
                }
                
            }
            
        } catch  {
            print("未找到场景")
        }
        
        
        return true
    }
    
    
    
    
    
    
    
    
}
