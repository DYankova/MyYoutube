//
//  FeedCell.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/10/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var videos: [Video]?
    //instantiate new collectionview inside the feedCell
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        //it is nessecary when put collectionView in a new view addSubview(collectionView)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"

    func fetchVideos(){
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            //refresh the videos
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        //represent each 4 section
        addSubview(collectionView)
        addConstraintsWithFotmat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFotmat(format: "V:|[v0]|", views: collectionView)
        //register the video cell 
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if counts is 0 return 0
        return videos?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item] ?? nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//when we tap on a video
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer(index: indexPath.item)
    }
}
