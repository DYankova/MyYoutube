//
//  SettingLauncher.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/5/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

//we use enum to prevent bugs if we change name of the settings
enum SettingName: String {
    case Cancel = "Cancel"
    case Setting = "Settings"
    case TermsPrivacy = "Terms & Privacy"
    case Feedback = "Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch account"
}

class SeetingsLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
//blackView is outside the method, because I will use it also in dismiss method
    var homeController: HomeController?
    let blackView = UIView()
    
  //block for items in settings box
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        let settingsSetting = Setting(name: .Setting, imageName: "settings")
        let termsSetting = Setting(name: .TermsPrivacy, imageName: "privacy")
        let feedbackSetting = Setting(name: .Feedback, imageName: "feedback")
        let helpSetting = Setting(name: .Help, imageName: "help")
        let switchSetting = Setting(name: .SwitchAccount, imageName: "swich")
        return [settingsSetting, termsSetting, feedbackSetting,
                helpSetting, switchSetting, cancelSetting]
    }()
    
func showSettings() {
    //desect all items, selected before
      if let indexPaths = collectionView.indexPathsForSelectedItems {
          indexPaths.forEach { self.collectionView.deselectItem(at: $0, animated: false) }
      }
    //show menu
    //this is the entire app view
    if let window = UIApplication.shared.keyWindow {
        //transperant color
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        //when user clicks somewhere on the screen
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        
        //the size of the settings box :
        let height: CGFloat = CGFloat(settings.count) * cellHeight //defined as 50
        let y = window.frame.height - height
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        blackView.frame = window.frame //entire screen
        //blackView.alpha is becoming from 0 to 1 with animation
        blackView.alpha = 0
        //for smoothing animation :.curveEaseOut
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: nil)
    }
}
    
  @objc func handleDismiss(){
    UIView.animate(withDuration: 0.5) {
        self.blackView.alpha = 0
        if let window = UIApplication.shared.keyWindow {
            //the setting box hides smoothly down
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }
    }
}
    
    //we should implement this 2 methods if we implement UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    //set a Setting object to settinsCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        let setting = settings[indexPath.item]//indexpath represents the row
        cell.setting = setting
        return cell
    }
    
    //show size of the collectionview cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight) //50
    }
    
    //minimes the spacing btw cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//when click on setting
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //to dissmiss when click
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                //the setting box hides smoothly down
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }, completion: nil)
        //when dismissal is completed show settings controller
        let setting = self.settings[indexPath.item]//which setting to show
        if setting.name != .Cancel {
             self.homeController?.showControllerForSetting(setting: setting) //for cancel the controller not show
        }
    }
     
    override init() {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //we should register the cell in init method!!
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
  }

