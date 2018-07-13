//
//  ApiService.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/8/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit
//in this class we will fetch video data from json
class ApiService {
    //Singleton
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) ->()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json"){  (videos) in
            completion(videos)
        }
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) ->()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json"){  (videos) in
            completion(videos)
        }
    }
    
    func fetchSubscriptionsFeed(completion: @escaping ([Video]) ->()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json"){  (videos) in
        completion(videos)
     }
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) ->()){
        //from json
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                return
            }
            do {
                //if we have wrap as ! , the app will crash if we have nil
                //double if let check - to avoid if let duplications
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: Any]] {
                        //new array of videos and fill it with videos get by title from the json array
//                        var videos = [Video]()
                        //!json is an array
//                        for dictionary in jsonDictionaries  {
//                            let video = Video(dictionary: dictionary)// when call init method we do the same things in Video
                            //insted of this we use setValuesForKeys
                            //  video.title = (dictionary["title"] as? String)!
                            //  video.thumnailImageName = (dictionary["thumbnail_image_name"] as? String)!
                            //  video.setValuesForKeys(dictionary)
//                              videos.append(video)
                
//                        }Example
//                    let nums[1,2,3]
//                    @0  = 1,2,3
                    //directly map the json to video object
                    let videos = jsonDictionaries.map({
                        return Video(dictionary: $0)
                    })
                        DispatchQueue.main.async {
                            completion(videos)
                        }
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
}


//video.setValuesForKeys(dictionary) - do the same 
//let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//var videos = [Video]()
//for dictionary in json as! [[String: Any]] {
//    let video = Video()
//    video.title = (dictionary["title"] as? String)!
//    video.thumnailImageName = (dictionary["thumbnail_image_name"] as? String)!
//    let channel = Channel()
//    let channelDict = dictionary["channel"] as! [String: Any]
//    channel.profileImageName = channelDict["profile_image_name"] as? String
//    channel.name = channelDict["name"] as? String
//    //set to video the channel from the json
//    video.channel = channel
//    videos.append(video)
//}
//DispatchQueue.main.async {
//    //to be reloaded
//    completion(videos)
//}
