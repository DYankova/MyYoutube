//
//  VideoCell.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/3/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import Foundation
import UIKit

class VideoCell : BaseCell {
    //dequereusablecell call the init method (in BaseCell)every time
   
    var video: Video? {
        //everytime the video is set
        didSet {
            titleLable.text = video?.title
            setupThumbnailImage()
           
            setupProfileImage()
            if let channelName = video?.channel?.name,  let number_of_views = video?.number_of_views {
    
            subTitTextView.text = "\(channelName) \(number_of_views)"
            }
            //TODO fix
            //measure title text
            if let videoTitle = video?.title {
                //spacings + size of title on 2 lines
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: videoTitle).boundingRect(with: size, options: options,  context: nil)
                if estimatedRect.size.height > 20 {
                    titleLblHeightConstrain?.constant = 44
                } else {
                    titleLblHeightConstrain?.constant = 20
                }
            }
        }
    }
    //to set the video'image - channel url from json
    func setupThumbnailImage()  {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
      //load image url from json
            thubnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    //to set the channel'image - chanell url from json
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profile_image_name {
          userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    
    let thubnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        //the image to fill good in the frame
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
       //set image in video object
        return imageView
    }()
    
    let userProfileImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green : 230/255, blue:230/255, alpha :1)
        return view
    }()
    

    let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       //set title in video object
        label.numberOfLines = 2
        return label
    }()
    
    let subTitTextView: UITextView = {
        let textView = UITextView()
        textView.text = "DIY channel"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.darkGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var titleLblHeightConstrain: NSLayoutConstraint?
    
    override func setupViews(){
        addSubview(thubnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLable)
        addSubview(subTitTextView)
        
        addConstraintsWithFotmat(format: "H:|-16-[v0]-16-|", views: thubnailImageView)
        //high constraints
        addConstraintsWithFotmat(format:  "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|",  views: thubnailImageView,userProfileImageView, separatorView)
       
        addConstraintsWithFotmat(format: "H:|-16-[v0(44)]|",   views: userProfileImageView)
        
        addConstraintsWithFotmat(format: "H:|[v0]|",   views: separatorView)
        
       addConstraintsWithFotmat(format: "H:|[v0]|",   views: separatorView)
        
        //left cons
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right cons
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .right, relatedBy: .equal, toItem: thubnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //top constraints
        //the titlelable is top-equal to the thubnailImageView
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .top, relatedBy: .equal, toItem: thubnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //hight cons
        
        titleLblHeightConstrain = NSLayoutConstraint(item: titleLable, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLblHeightConstrain!)
        
        
        //left cons
        addConstraint(NSLayoutConstraint(item: subTitTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right cons
        addConstraint(NSLayoutConstraint(item: subTitTextView, attribute: .right, relatedBy: .equal, toItem: thubnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //top constraints
        //the titlelable is top-equal to the thubnailImageView
        addConstraint(NSLayoutConstraint(item: subTitTextView, attribute: .top, relatedBy: .equal, toItem: titleLable, attribute: .bottom, multiplier: 1, constant: 4))
        //hight cons
        addConstraint(NSLayoutConstraint(item: subTitTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        thubnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    

 
    
}

