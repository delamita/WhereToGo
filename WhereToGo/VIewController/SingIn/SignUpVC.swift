//
//  SignUpVC.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/26.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit
import Photos

class SignUpVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var finishEdit: UIBarButtonItem!
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    @IBOutlet weak var avaImage: UIImageView!
    
    @IBOutlet weak var avaShadow: UIImageView!
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordCf: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        avaImage.layer.cornerRadius = avaImage.frame.width/2
        avaShadow.layer.cornerRadius = avaShadow.frame.width/2
        
        
        if let statusViewWindow =  UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow {
            
            if let statusView = statusViewWindow.value(forKey: "statusBar") as? UIView {
                statusView.backgroundColor = UIColor.yellow
            }
            
        }

        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finishClk(_ sender: Any) {
        
        if self.password.text == self.passwordCf.text {
            
            let user = User()
            
            user.avaImage = self.avaImage.image
            user.phoneNumber = self.phoneNumber.text
            user.password = self.password.text
            user.userName = self.userName.text
            
            switch user.signUp() {
                
            case (true, 0) :
                showMessagbox(viewController: self, message: "注册成功")
                _ = user.singIn()
                
            case (false, 0):
                showMessagbox(viewController: self, message: "信息未输入完全")
            
            case (false, 1):
                showMessagbox(viewController: self, message: "手机号已注册，请直接登录")
                
            default: break
                
            }
            
        }
        else{
            showMessagbox(viewController: self, message: "两次输入的b密码不同")
        }
        
        
    }
    
    
    
    
    

    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        scrollView.contentSize = self.view.frame.size
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-200)
        
        
    }
    
    
    
    @IBAction func endEdit(_ sender: Any) {
        
        self.view.endEditing(true)
        scrollView.frame = self.view.frame
        
    }
    
    
    
    @IBAction func getPic(_ sender: Any) {
        
        let PhotoPicker = UIImagePickerController()
        
        PhotoPicker.delegate = self
        
        self.present(PhotoPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.avaImage.image = pickedImage
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
