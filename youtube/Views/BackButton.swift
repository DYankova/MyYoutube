////
////  BackButton.swift
////  youtube
////
////  Created by Dilyana Yankova on 7/17/18.
////  Copyright © 2018 Dilyana Yankova. All rights reserved.
////
//
//import UIKit
//
//class BackButtonView: UIView {
//    
//    var videoPlayer: VideoPlayerView?
//    
////    lazy var backButton: UIButton = {
////        let btn  = UIButton(type: .system)
////        let image = UIImage(named: "back")
////        btn.translatesAutoresizingMaskIntoConstraints = false
////        btn.setImage(image, for: .normal)
////        btn.tintColor = UIColor.black
////
////        btn.addTarget(self, action: #selector(backButtonPresed), for: .touchUpInside)
////
////        return btn
////    }()
////
////    @objc func backButtonPresed(){
////       videoPlayer?.player?.pause()
////        //TODO make smooth animation
////        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
////        _ = appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
////
////        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32 , blue: 31, alpha: 1)
////
////        // get rid of the black bar underneath the nav bar
////        UINavigationBar.appearance().shadowImage = UIImage()
////        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
////
//////        application.statusBarStyle = .lightContent
////
////        let statusBarBackgroundView = UIView()
////        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 184, green: 21 , blue: 21, alpha: 1)
////
////        window?.addSubview(statusBarBackgroundView)
////        window?.addConstraintsWithFotmat(format: "H:|[v0]|", views: statusBarBackgroundView)
////        window?.addConstraintsWithFotmat(format: "V:|[v0(20)]", views: statusBarBackgroundView)
////    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
//        addSubview(backButton)
//        backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 15).isActive = true
//        backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
//        backButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
