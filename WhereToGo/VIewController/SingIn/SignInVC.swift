//
//  SignInVC.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/26.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var SignInBt: UIButton!
    
    @IBOutlet weak var shadowView: UIImageView!
    @IBOutlet weak var shadowView2: UIImageView!
    @IBOutlet weak var shadowView3: UIImageView!
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    

    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.shadowView.layer.borderWidth = 2
        self.shadowView2.layer.borderWidth = 2
        self.shadowView3.layer.borderWidth = 2
        self.userNameText.layer.borderWidth = 2
        self.passwordText.layer.borderWidth = 2       
        self.SignInBt.layer.borderWidth = 2

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignInBtClk(_ sender: Any) {
        
    }
    
    
    @IBAction func EndEdit(_ sender: Any) {
        
        self.view.endEditing(true)
        
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
