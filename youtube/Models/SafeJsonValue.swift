//
//  SafeJsonValue.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/13/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class SafeJsonValue: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        //catch the setting of value based on the key!
        let upprCasedFirstChar = String(key.characters.first!).uppercased() //make first letter upper
        let range = key.startIndex...key.index(key.startIndex, offsetBy: 0) //very first char
        let selectorString = key.replacingCharacters(in: range, with: upprCasedFirstChar)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds  = self.responds(to: selector)
        //if it is not the same go away from the func
        if !responds {
            return
        }
        super.setValue((value), forKey: key)
    }
}

