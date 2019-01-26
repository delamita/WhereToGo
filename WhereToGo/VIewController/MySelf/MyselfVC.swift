//
//  MyselfVC.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/26.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit



/// 我的页面VC
class MyselfVC: UIViewController {

    @IBOutlet weak var SignOut: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutClk(_ sender: Any) {
        
        _ = User.signOut()
        
    }
    
    
    @IBAction func printAllUser(_ sender: Any) {
        
        DataBase.showAlluserName()
        
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
