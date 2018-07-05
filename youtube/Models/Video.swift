//
//  Video.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/4/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

//to represent the video - each video...what to render
class Video: NSObject {
    var thumnailImageName: String = ""
    var title: String = ""
   
    //not goint to use them now
    var numberOfViews : NSNumber?
    var uploadDate: NSDate?
    
    //each video belongs to channel
    var channel: Channel?
}
