//
//  TrendingCell.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/10/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    //we need differend feed for different tabs
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
}
