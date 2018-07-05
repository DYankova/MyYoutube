//
//  SettingLauncher.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/5/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class SeetingsLauncher: NSObject {
    
//blackView is outside the method, because I will use it also in dismiss method
let blackView = UIView()
  //block for items in settings box
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
func showSettings() {
    //show menu
    //this is the entire app view
    if let window = UIApplication.shared.keyWindow {
        
        //transperant color
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        //when u click somewhere on the sceen (the whole blackView)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hadleDismiss)))
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        //the size of the settings box
        let height: CGFloat = 200
        let y = window.frame.height - height
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
    
        blackView.frame = window.frame
        
        //blackView.alpha is becoming from 0 to 1 with animation
        blackView.alpha = 0
        //for smoothing animation :.curveEaseOut
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: nil)
    }
}
 //when click outside
  @objc func hadleDismiss(){
    UIView.animate(withDuration: 0.5) {
        self.blackView.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            //the setting box hides smoothly down
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }
    }
}

    
    
    
    
    
    override init() {
        super.init()
    }
  }

