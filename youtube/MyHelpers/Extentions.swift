//
//  FExtentions.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/3/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat , green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/244, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFotmat(format :String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views:  viewsDictionary))
  }
}

//not to reload images to the reused video cells, but keep them in Cache
let imageCache = NSCache<AnyObject, AnyObject>()

//we use Class not extension in order to check if imageUrlsString to urlsString from method param
class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        image = nil
        //search the image in cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            self.image = imageFromCache as? UIImage
            return //else go out and set it
        }
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI quickly
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    
                    //if the images is not changed add it to cache
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    //add image to cache
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
            }
            
            }.resume()
    }
}
