//
//  User.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit
import Foundation
import CoreData


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
    
    
    
    class func getUser(withPhoneNumber: String) -> User? {
        
        return DataBase.getUser(withPhoneNumber:withPhoneNumber)
    }
    
    
    
    
    
    /// 通过电话号码和密码登陆为当前用户。如果登陆成功跳转到首页，并返回true，失败返回false
    ///
    /// - Parameters:
    ///   - wihtphoneNumber: <#wihtphoneNumber description#>
    ///   - password: <#password description#>
    /// - Returns: 登陆成功返回true，失败返回false
    
    
    class func signIn(wihtphoneNumber: String, password: String) -> Bool {
        
        if let user = User.getUser(withPhoneNumber: wihtphoneNumber) {
            
            if user.password == password{
                
                App.currentUser = user
                
                UserDefaults.standard.set(wihtphoneNumber, forKey: "phoneNumber")
                UserDefaults.standard.set(password, forKey: "password")
                
                
                print(log: "成功登陆用户：" + user.userName!)
                
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                
                let nvc = storyboard.instantiateViewController(withIdentifier: "RootTabVC") as! UITabBarController
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = nvc
                
                return true
            }
        }
        return false
    }
    
    
    
    func singIn() -> Bool {
        
        return User.signIn(wihtphoneNumber: self.phoneNumber!, password: self.password!)
        
    }
    
    
    
    /// 登陆存储在UserDefault中的账户，如果没有存储则不登陆
    /// 该函数应当在程序运行初调用
    /// - Returns: true：成功登陆；false：没有默认的账户
    
    class func defaultSignIn() -> Bool {
        
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        let password = UserDefaults.standard.string(forKey: "password")
        

        if phoneNumber != nil && password != nil {
            
            if User.signIn(wihtphoneNumber: phoneNumber!, password: password!) {
                
                print(log: "成功登陆默认账户" )
                return true
                
            }
            
        }
        
        print(log: "没有默认账户，需要重新登陆")
        
     return false
    }
    
    
    
    
    /// 注销当前用户,返回登陆界面
    ///
    /// - Returns: 注销成功返回true
    class func signOut() -> Bool {
        
        
        
        App.currentUser = nil
        
        UserDefaults.standard.removeObject(forKey: "phoneNumber")
        UserDefaults.standard.removeObject(forKey: "password")

        print(log: "成功注销用户" )
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let nvc = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        
        let ad = UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController = nvc
        
        
        
        return true
    }
    
    
    
    
    /// 注册用户,并存储到数据库
    ///
    /// - Returns: (false, 1)：手机号已注册， (false, 0):信息不完整,(true, 0)注册成功
    func signUp() -> (Bool, Int) {
        
        if self.userName == nil || self.password == nil || self.phoneNumber == nil || self.avaImage == nil {
            print(log: "信息不完整")
            return (false, 0)
        }
        
        if User.getUser(withPhoneNumber: self.phoneNumber!) != nil {
            print(log: "注册失败：手机号码已被注册")
            return (false, 1)
        }
        
        if self.saveToDB() {
            print(log: "成功注册用户："+self.userName!)
        }
        else{
            print(log: "用户保存到数据库失败")
        }
        
        return (true, 0)
    }
    
    
    
    
}


