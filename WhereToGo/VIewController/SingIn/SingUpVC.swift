//
//  SingUpVC.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/26.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

class SingUpVC: UIViewController {
    
    @IBOutlet weak var finishEdit: UIBarButtonItem!
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    @IBOutlet weak var avaImage: UIImageView!
    
    @IBOutlet weak var avaShadow: UIImageView!
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        avaImage.layer.cornerRadius = avaImage.frame.width/2
        avaShadow.layer.cornerRadius = avaShadow.frame.width/2

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finishClk(_ sender: Any) {
        
        
    }
    
    
    

    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
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
