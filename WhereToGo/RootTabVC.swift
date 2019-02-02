//
//  RootTabVC.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/2/2.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

class RootTabVC: UITabBarController,UITabBarControllerDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController == self.viewControllers![2] {
            
            let nvc = storyboard?.instantiateViewController(withIdentifier: "NVCofNewScene")
            
            nvc?.modalPresentationStyle = .fullScreen
            
            self.present(nvc!, animated: true, completion: nil)
            
            return false
        }
        else{
            return true
        }
        
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
