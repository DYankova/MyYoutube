//
//  Setting.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/13/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit
//model object of the settings
class Setting {
    let name: SettingName
    let imageName: String
    
    //to initialize name, imageName
    init(name: SettingName, imageName: String) {
        self.imageName = imageName
        self.name = name
    }
}
