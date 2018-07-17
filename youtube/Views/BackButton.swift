//
//  BackButton.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/17/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class BackButtonView: UIView {
    var homeController: HomeController?
    
    lazy var backButton: UIButton = {
        let btn  = UIButton(type: .system)
        let image = UIImage(named: "back")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor.black
        
        btn.addTarget(self, action: #selector(backButtonPresed), for: .touchUpInside)
        return btn
    }()
    
    @objc func backButtonPresed(){
        print("blala")
        //TODO make smooth animation
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(backButton)
        backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 15).isActive = true
        backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

