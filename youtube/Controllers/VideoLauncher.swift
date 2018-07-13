//
//  VideoLauncher.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/12/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject { //if we have NSobject we dont have access to any views
    
    func showVideoPlayer(){
        //we get the whole app window - container that holds the whole app
        if let keyWindow = UIApplication.shared.keyWindow { //begining frame
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
           //16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView) //open the video
            keyWindow.addSubview(view)
        
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame//ending frame
            }) { (completedAnimation) in
                //hide the status bar when open video
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
    
}
