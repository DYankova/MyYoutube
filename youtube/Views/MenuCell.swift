//
//  MenuCell.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/4/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)//for using tintcolor
//        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        return iv
        }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor =   isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        //28 shows the size
        addConstraintsWithFotmat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFotmat(format: "V:[v0(28)]", views: imageView)
        //in order to center the image itself
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
