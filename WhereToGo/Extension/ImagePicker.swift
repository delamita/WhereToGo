//
//  ImagePicker.swift
//  Instagrame
//
//  Created by 费克翔 on 2018/1/2.
//  Copyright © 2018年 Crazzy. All rights reserved.
//

import UIKit
import Photos



class ImagePicker: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate{
    
    
    var inputVC : UIViewController?
    
    
    var assetsFetchResults:PHFetchResult<PHAsset>?
    var imageManager:PHCachingImageManager!
    
    var isCellSellected = [Bool]()
    var selectedNumber = [Int]()
    

    
    var selectedCells = [SelectCell]()
    
    var requistedImage: UIImage?

    /// 最终返回的图片.仅在最后传图片时调用加载原图
    var selectedImages = [UIImage]()
    
    
    /// 是否是多选
    private var prIsMultiChooseAble = false
    
    /// 是否是多选
    var isMultiChooseAble:Bool{
        get{
            return prIsMultiChooseAble
        }
        set{
            prIsMultiChooseAble = newValue
            for c in selectedCells{
                c.cell.numberBut.isHidden = !prIsMultiChooseAble
            }
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (assetsFetchResults?.count)!
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePickerCell", for: indexPath) as! ImagePickerCell

        if let asset = assetsFetchResults?[indexPath.row] {
            
  
        
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .default, options: nil) {
                (result, info) in
                if result != nil{
                    cell.imageView.image = result
                }
                
            }
        }
        
        
        cell.numberBut.layer.cornerRadius = 10

        cell.indexPath = indexPath
        
        if isCellSellected[indexPath.row] {
            
            cell.isImageSeleted = true
            cell.selectedmask.isHidden = false
        
            if isMultiChooseAble {
                
                if selectedNumber[indexPath.row] == 0{
                    cell.numbersOfSelected = nil
                }
                else{
                    cell.numbersOfSelected = selectedNumber[indexPath.row]
                }
                cell.numberBut.isHidden = false
                
            }
        }
        else{
            cell.isImageSeleted = false
            cell.selectedmask.isHidden = true
            if isMultiChooseAble{
                cell.numberBut.isHidden = true
            }
        }

        return cell
    }
    
    
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var multiChooseBut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        
        multiChooseBut.layer.cornerRadius = multiChooseBut.frame.width/2
        multiChooseBut.backgroundColor = UIColor.fromDisplayP3(red: 0, green: 0, blue: 0, alpha: 0.65)
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(log: "点击了 "+String(describing: indexPath))
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImagePickerCell
        
        if isMultiChooseAble {
            
            if cell.isImageSeleted{
                
                if selectedCells.count > 1 {
                    cancelSelected(cell: cell)
                }
                else{
                    print(log: "多选的最后一个图片，不能取消")
                }
                
            }
            else{
                selectCell(cell: cell)
            }
            
        }
        else{
            
            for c in selectedCells{
                cancelSelected(cell: c.cell)
            }
            
            selectedCells.removeAll()
            selectCell(cell: cell)
            
        }
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func multiChoose(_ sender: UIButton) {
        
        if isMultiChooseAble {
            
            isMultiChooseAble = false
            
            if var lastCell = selectedCells.last{
                
                for c in selectedCells{
                    cancelSelected(cell: c.cell)
                    selectedNumber[c.indexPath.row] = 0
                }
                
                lastCell.setNumber(newValue: nil)
                
                selectCell(cell: lastCell.cell)
                sender.backgroundColor = UIColor.fromDisplayP3(red: 0, green: 0, blue: 0, alpha: 0.65)
            }
            
        }
        else {
            
            isMultiChooseAble = true
            
            let scell = selectedCells.first
            
            if  scell != nil {
                
                cancelSelected(cell: (scell?.cell)!)
                selectCell(cell: (scell?.cell)!)
                
            }
            
            sender.backgroundColor = UIColor.yellow
            
            
        }
//        collectionView.reloadData()
    }
    
    
    
    func initCollectionView() {

        let assetOptions = PHFetchOptions()
        assetOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        assetsFetchResults = PHAsset.fetchAssets(with: assetOptions)
        
        if let n = assetsFetchResults?.count {
            for _ in 0..<n{
                isCellSellected.append(false)
                self.selectedNumber.append(0)
            }
        }
        
    }
    
    
    @IBAction func cancelBtClk(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    @IBAction func nextStep(_ sender: UIBarButtonItem) {
        
        let ovc = self.inputVC as! NewScene
        ovc.images = self.selectedImages
        ovc.images?.append(UIImage(named: "addImageInco")!)
        
        self.dismiss(animated: true, completion: nil)

        
    }
    

    
    func selectCell(cell: ImagePickerCell) {
        
        if cell.isImageSeleted {
            
            print(log: "Cell已选中")
            
            return
        }
        else{
            
            var scell = SelectCell(cell: cell)
            
            cell.isImageSeleted = true
            
            if isMultiChooseAble{
                scell.setNumber(newValue: selectedCells.count+1)
            }
  
            
            self.selectedCells.append(scell)
            self.selectedImages.append(cell.imageView.image!)
            
            isCellSellected[(cell.indexPath?.row)!] = true
            
            if cell.numbersOfSelected == nil{
                selectedNumber[(cell.indexPath?.row)!] = 0
            }
            else{
                selectedNumber[(cell.indexPath?.row)!] = cell.numbersOfSelected!
            }
            
            print(log: "select "+String(describing: cell.indexPath))
        
            getlargeImage(cell: cell)
            
            print(log: "selectedImages:\(selectedImages.count)   selectedCells:\(selectedCells.count)")
        }
        

    
    }
    
    
    
    
    func cancelSelected(cell: ImagePickerCell) {
        
        cell.isImageSeleted = false
        isCellSellected[(cell.indexPath?.row)!] = false
        
        if isMultiChooseAble {
            
            var number: Int? = nil
            
            if selectedCells.count <= 1{
                
                selectedCells.removeAll()
                selectedImages.removeAll()
                
                return 
            }

            number = selectedCells[cell.numbersOfSelected!-1].number
            
            selectedCells.remove(at: cell.numbersOfSelected!-1)
            selectedImages.remove(at: cell.numbersOfSelected!-1)
            
            print(log: String(describing: number))
            
            cell.numbersOfSelected = nil
            cell.numberBut.isHidden = true
            
            for i in 0..<selectedCells.count {
                
                var sc = selectedCells[i]
                if sc.number! >= number!{
                    sc.number = sc.number!-1
                }
                
            }
            
            for i in 0..<selectedNumber.count{
                if selectedNumber[i] >= number! {
                    selectedNumber[i] = selectedNumber[i]-1
                }
            }
            
            
            
        }
        else{
            selectedCells.removeAll()
            selectedImages.removeAll()
        }
        

        
        selectedNumber[(cell.indexPath?.row)!] = 0
        
        print(log: "selectedImages:\(selectedImages.count)   selectedCells:\(selectedCells.count)")
        
        
    }
    
    
    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    func getlargeImage(cell: ImagePickerCell) {
        
        if let asset = assetsFetchResults?[(cell.indexPath?.row)!] {
            
            
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) {
                (result, info) in
                
                if result != nil{
                    self.largeImageView.image = result!
                }

            }
            

        }
        else{
            print(log: "未能成功读取到原图")
        }
        
    }
    
    
    
    @IBAction func pause(_ sender: Any) {
        
        
        print(selectedImages)
        print(selectedCells)
        
    }
    
    
    
    
    
    
    func chooseFirstCell() {
        
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ImagePickerCell
        
        selectCell(cell: cell)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if selectedCells.isEmpty {
            chooseFirstCell()
        }
    }
    

    
}



class ImagePickerCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedmask: UIButton!
    @IBOutlet weak var numberBut: UIButton!
    
    var indexPath:IndexPath?
    
    private var prisImageSelected = false
    private var prnumbersInSelected:Int? = nil
    
    var isImageSeleted:Bool {
        get{
            return prisImageSelected
        }
        set{
            prisImageSelected = newValue
            if prisImageSelected == false{
                self.selectedmask.isHidden = true
            }
            else{
                self.selectedmask.isHidden = false
            }
            
        }
    }
    
    var numbersOfSelected:Int?{
        get{
            return prnumbersInSelected
        }
        set{
            prnumbersInSelected = newValue
            if newValue==nil {
                numberBut.setTitle(nil, for: .normal)
            }
            else{
                numberBut.setTitle(String(describing: prnumbersInSelected!), for: .normal)
            }

        }
    }
    

    
}















