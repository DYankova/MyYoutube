//
//  SettingsCell.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/6/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class SettingsCell : BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Settings"
        return label
    }()
    
    let iconImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = UIColor.white
            backgroundColor = isSelected ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isSelected ? UIColor.white :  UIColor.black
            iconImage.tintColor = isSelected ? UIColor.white :  UIColor.black
        }
    }
   
    var setting: Setting? {
        didSet {
            //set to the name of the label - names of the settings objects (from the [])
            nameLabel.text = (setting?.name).map { $0.rawValue }
            if let imageName = setting?.imageName{
                iconImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)//for using tintcolor
                iconImage.tintColor = UIColor.darkGray
            }
        }
    }
   
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImage)
        //8 px from v1 which is nameLabel and 8 px right; setting up 30 gives the namaLabel v1 the rest of the cell size
        addConstraintsWithFotmat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImage , nameLabel)
        addConstraintsWithFotmat(format: "V:|[v0]|", views: nameLabel)
       
        addConstraintsWithFotmat(format: "V:[v0(30)]", views: iconImage)
        //this constraint aligns the settings icon to the nameLabel, centeres it to its y
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
