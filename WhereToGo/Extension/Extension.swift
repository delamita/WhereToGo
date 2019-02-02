//
//  Extension.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import Foundation
import UIKit
import Photos


extension UIView{
    
    
    /// 设置默认的阴影
    func setShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.layer.shadowColor = UIColor.lightGray.cgColor;
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.8
    }
    
    func setShadow(color: CGColor,shadowRadius: CGFloat, shadowOpacity: Float) {
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.layer.shadowColor = color
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
    
    
    func corner(byRoundingCorners corners: UIRectCorner, cornerRadius radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}


extension Error{
    
    func print() {
        Swift.print(self)
    }
    
    func print(log: String) {
        
        Swift.print("")
        Swift.print("/tLog: "+log)
        Swift.print("")
        Swift.print(self)
        Swift.print("")
        
    }
    
}


func print(error: Error){
    print(error)
}


func print(error: Error, log: String){
    
    print("")
    print("\tLog: "+log)
    print("")
    print(error)
    print("")
    
}


func print(log: String){
    
    print("")
    print("\tLog: "+log)
    print("")
    
}



// MARK: - 对UIColor添加一些j扩展
extension UIColor{
    
    
    
    /// 从P3色域下的RGB和alpha值转化得到UIColor类
    ///
    /// - Parameters:
    ///   - red: <#red description#>
    ///   - green: <#green description#>
    ///   - blue: <#blue description#>
    ///   - alpha: <#alpha description#>
    /// - Returns: 得到的颜色
    class func fromDisplayP3(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    

    ///系统默认的按钮蓝色
    static var buttnColor:UIColor{
        return UIColor.fromDisplayP3(red: 84, green: 146, blue: 234, alpha: 1)
    }
    
}




/// 在VC弹出MessageBox
///
/// - Parameters:
///   - viewController: 弹出MessageBox的VC
///   - message: 提示的信息
///   - title: 提示的标题，默认为“提示”
func showMessagbox(viewController: UIViewController, message: String, title: String = "提示" ){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
    alert.addAction(btnOK)
    viewController.present(alert, animated: true, completion: nil)
    
}




extension UIViewController {
    class func current(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        return base
    }
}




struct SelectCell{
    
    var cell : ImagePickerCell
    
    var number :Int?{
        get{
            return cell.numbersOfSelected
        }
        set{
            cell.numbersOfSelected = newValue
            if newValue == nil {
                
                cell.numberBut.isHidden = true
            }
            else{
                cell.numberBut.isHidden = false
            }
            
        }
    }
    
    var indexPath : IndexPath
    
    mutating func setNumber(newValue: Int?)  {
        self.number = newValue
    }
    
    
    init(cell: ImagePickerCell) {
        self.cell = cell
        self.indexPath = cell.indexPath!
    }
    
}




func cutTags(tag: String) -> [String] {
    
    var tags = tag.components(separatedBy: "#")
    tags.remove(at: 0)
    print(tags)
    
    return tags
}


func verbTags(tags: [String]) -> String {
    
    var tag = ""
    
    for i in tags {
        tag += "#"+i
    }
    return tag
}
    
