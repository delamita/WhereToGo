//
//  User.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit


/// 用户
class User: NSObject {
    
    
//    注意：User类中的属性应当与DB中DBUser的属性一一对应，且属性的命名应当一致。
    
    var userName: String?
    var password: String?
    var phoneNumber: String?
    var avaImage: UIImage?
    
    
    convenience init(userName: String?, password: String?, phoneNumber: String?, avaImage: UIImage? ){
        
        self.init()
        
        self.userName = userName
        self.password = password
        self.phoneNumber = phoneNumber
        self.avaImage = avaImage
        
        
    }

}

extension User{
    
    func saveToDB() -> Bool {
        
        return DataBase.createNewUser(user: self)
    }
    
    
    class func getUser(withPhoneNumber: String) -> User {
        
        return DataBase.getUser(withPhoneNumber:withPhoneNumber)
    }
    
    
    
    
}
