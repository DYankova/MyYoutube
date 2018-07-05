//
//  MenuBar.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/4/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32 , blue: 31, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
        }()
    
    //register the cellid
     let cellId = "cellId"
     let imageNames = ["home","fire","play","user"] //names of icos should be registered
    
    override init (frame: CGRect){
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    
        addSubview(collectionView)
        addConstraintsWithFotmat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFotmat(format: "V:|[v0]|", views: collectionView)
      
        //first tabitem should be selected when app launch
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .bottom)
    }
    
    
    //two methods! :numberOfItemsInSection (how many cells) and cellForItemAt (wich is the cell)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
       //as ! MenuCell - dowlncast the cell what cell it returns in order to use indexpath
//        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        
        //tintcolor makes the icon uncolored
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        return cell
    }

    //size of each cell in nav bar
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4 , height:  frame.height)
    }
    //no space btw cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
required init?(coder aDecoder: NSCoder) {
    fatalError("no init implemented")
    
  }
    
    
   
   
    
}
