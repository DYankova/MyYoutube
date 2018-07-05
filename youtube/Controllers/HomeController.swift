//
//  ViewController.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/3/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //create list of sample videos here
//    var videos: [Video] = {
//        var DIYchannel = Channel ()
//        DIYchannel.name = "Dilyana Yankova's persoal channel"
//        DIYchannel.profileImageName = "sample"
//
//        var firstVideo = Video()
//        firstVideo.title = "Didi video birds near metrostation Serdika"
//        firstVideo.thumnailImageName = "run_didi"
//        firstVideo.channel = DIYchannel
//
//        var secVideo = Video()
//        secVideo.title = "Didi video office"
//        secVideo.thumnailImageName = "woman-lego-computer"
//        secVideo.channel = DIYchannel
//        return [firstVideo,secVideo]
//    }()
    
    var videos: [Video]?
   
    func fetchVideos(){ //from json
        //get json from AWS...
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                //new array of videos and fill it with videos get by title from the json array
                self.videos = [Video]()
                
                //!json is an array
                for dictionary in json as! [[String: Any]] {
                 let video = Video()
                    video.title = (dictionary["title"] as? String)!
                    video.thumnailImageName = (dictionary["thumbnail_image_name"] as? String)!
                    
                    let channel = Channel()
                    let channelDict = dictionary["channel"] as! [String: Any]
                    channel.profileImageName = channelDict["profile_image_name"] as? String
                    channel.name = channelDict["name"] as? String
                   //set to video the channel from the json
                    video.channel = channel
                    self.videos?.append(video)
                }
                
                
                DispatchQueue.main.async {
                //to be reloaded
                 self.collectionView?.reloadData()
                }
                
            } catch let jsonError {
              print(jsonError)
            }
            
            //encode it to utf8 if  I want to see the result
//            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        }.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchVideos()
        navigationController?.navigationBar.isTranslucent = false
        
        //to be able to change title position set a label
        let titleViewLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = titleViewLbl
        titleViewLbl.text = "Home"
        titleViewLbl.textColor = UIColor.white
        titleViewLbl.font = UIFont.systemFont(ofSize: 20)
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        //to scroll the view under the nav bar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        //menubar + navigationbar (navigationItem)
        setupMenuBar()//up
        setupNavBarButtons()//down
    }
    
      func  setupNavBarButtons() {
        let searchImage = UIImage(named: "search-")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMoreButton))
       
//        navigationItem.rightBarButtonItems = [searchBarButtonItem]
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    let settingsLauncher = SeetingsLauncher()
    @objc func handleSearch() {
        
    }

    
    @objc func handleMoreButton() {
        //show menu
        settingsLauncher.showSettings()
    }
    
    //in a block
    let menuBar: MenuBar = {
        let mb = MenuBar()//cell
        return mb
    }()
    
    
    
     func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFotmat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFotmat(format: "V:|[v0(50)]", views: menuBar)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        //if counts is 0 return 0
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item] ?? nil

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

