//
//  HomePageVC.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/26.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var scenes: [Scene]?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if scenes != nil {
            return scenes!.count
        }
        else{
            
            showMessagbox(viewController: self, message: "一个场景都没有")
            
            return 0
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homepageSceneCell", for: indexPath) as! homepageSceneCell
        
        cell.image.image = scenes?[indexPath.row].images?.first
        cell.tagsL.text = verbTags(tags: (scenes?[indexPath.row].tags)!)
        
        return cell
    }
    
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nvb = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = nvb
        
        scenes = Scene.getAllScene()

        // Do any additional setup after loading the view.
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



class homepageSceneCell : UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var tagsL: UILabel!
    
    
    
}
