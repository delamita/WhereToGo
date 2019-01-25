//
//  Scene.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit
import MapKit

let  sceneidStart = 10000


class Scene: NSObject {
    
    var name: String?
    var title: String?
    var describe: String?
    
    var tags: [String]?
    var phone: String?
    var price: Int?
    
    var address: String?
    
    var sceneId: String
    var images: [UIImage]?
    var owner: User?
    
    var comments: [Comment]?
    
    
    
    //    var likes: Int?
    
    
    
    override init(){
        
        self.sceneId = ""
        
    }
    
    
    
    convenience init(sceneId: String) {
        
        self.init()
        self.sceneId = sceneId
    }
    
    
    
    
    convenience init(name: String?, title: String?, describe: String?) {
        
        self.init()
        
        self.name = name
        self.title = title
        self.describe = describe
    }
    
    
    
}




extension Scene{
    
    func saveToDB() -> Bool {
        return  DataBase.createNewScene(scene: self)
    }
    
    
    class func getScene(withSceneId: String) -> Scene {
        
        return DataBase.getScene(withSceneId:withSceneId)
    }
    
    
    func addComment(user: User,text: String) -> Bool {
        
        let comment = Comment(owner: user, text: text)
        comment.scene = self
        
        return true
    }
    
    
    
}
