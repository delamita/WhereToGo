//
//  NewScene.swift
//  WhereToGo
//
//  Created by 徐夷琦 on 2019/1/31.
//  Copyright © 2019 徐夷琦. All rights reserved.
//

import UIKit

class NewScene: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate{
    
    var images : [UIImage]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if images != nil {
            return images!.count
        }
        else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "newSceneImageAddCell", for: indexPath) as! newSceneImageAddCell
        
        cell.imageView.image = images![indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row+1 == images!.count {
            
            print("选择了添加图片")
            
            let nvc = storyboard?.instantiateViewController(withIdentifier: "ImagePicker") as! ImagePicker
            
            nvc.inputVC = self

            self.present(nvc, animated: true, completion: nil)
            
        
        }
        

    }
    
    
    
    @IBOutlet weak var nameL: UITextField!
    @IBOutlet weak var titleL: UITextField!
    @IBOutlet weak var tagsL: UITextField!
    @IBOutlet weak var priceL: UITextField!
    @IBOutlet weak var phoneL: UITextField!
    @IBOutlet weak var addressL: UITextField!
    @IBOutlet weak var sceneIdL: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var tapGuesture: UITapGestureRecognizer!
    
    @IBOutlet weak var describeL: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [UIImage]()
        
        images?.append(UIImage(named: "addImageInco")!)
        
        collectionView.reloadData()
        
        nameL.placeholder = "名称"
        titleL.placeholder = "简介"
        tagsL.placeholder = "#标签"
        priceL.placeholder = "人均消费"
        addressL.placeholder = "地址"
        phoneL.placeholder = "电话"
        sceneIdL.placeholder = "SceneId"
        describeL.text = "详情"
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.collectionView.reloadData()
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view?.isDescendant(of: self.collectionView))! {
            return false
        }
        else{
            return true
        }
        
    }

    
    
    @IBAction func endEdit(_ sender: Any) {
        
        self.view.endEditing(true)
        
    }
    
    
    
    
    
    @IBAction func cancleBClk(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveSceneBTClk(_ sender: Any) {
    
        let scene = Scene(name: nameL.text, title: titleL.text, describe: describeL.text)
        
        scene.address = addressL.text
        
        if priceL.text != nil {
            scene.price = Int(addressL.text!)
        }
        
        if tagsL.text != nil {
            scene.tags = cutTags(tag: tagsL.text!)
        }
        
        scene.owner = App.currentUser
        scene.phone = phoneL.text
        
        if sceneIdL.text !=  nil {
            scene.sceneId = sceneIdL.text!
        }
        
        scene.images = self.images
        
        if scene.saveToDB() {
            showMessagbox(viewController: self, message: "保存成功")
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




class newSceneImageAddCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
}
