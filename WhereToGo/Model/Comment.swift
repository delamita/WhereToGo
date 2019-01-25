//
//  Comment.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/25.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

class Comment: NSObject {
    
    var owner = User()
    var text = ""
    
    var creatTime = Date()
    
    var scene = Scene()
    
    init(owner: User, text: String) {
        
        self.owner = owner
        self.text = text
        self.creatTime = Date()
        
    }

}
