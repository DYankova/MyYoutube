//
//  VideoPlayerView.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/12/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit
import AVFoundation //for using AViplayer

class VideoPlayerView: UIView {
    
    var isPlaying = false
    var player: AVPlayer?
    
    //add spinned into controlscontainerView!!
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false //we will add it using constraints, thats why it should be set
        aiv.startAnimating() //animation
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = { //lazy var - to have access to self
        let btn  = UIButton(type: .system)
        let image = UIImage(named: "pause_btn")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor.white
        btn.isHidden = true //it should be shown after video is loaded
        btn.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return btn
    }()
   
   @objc func handlePause(){
     if isPlaying {
       player?.pause()
       pausePlayButton.setImage(UIImage(named: "play_btn"), for: .normal)
     } else {
       player?.play()
       pausePlayButton.setImage(UIImage(named: "pause_btn"), for: .normal)
     }
      isPlaying = !isPlaying
}
    
    //we create view above the player to add a s spinner in this view
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    lazy var videoslider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named: "red"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChande), for: .valueChanged) //when click smwhere on the slider
        return slider
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
   @objc func handleSliderChande() {
    
    if let duration = player?.currentItem?.duration {
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(videoslider.value) * totalSeconds
        let seekTime  = CMTime(value: Int64(value), timescale: 1)
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
        })
     }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true //center it
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-2).isActive = true
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoslider)
        videoslider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoslider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoslider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true//starts just after it
        videoslider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = UIColor.black //before video loaded
    }
    
    //we add the exact player
        func setupPlayerView() {
            let urlString = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
            //make url from string
            if let url = NSURL(string: urlString) {
                player = AVPlayer(url: url as URL)
                //we need to add playerlayer to run the video
                let playerLayer = AVPlayerLayer(player: player)
                self.layer.addSublayer(playerLayer)
                playerLayer.frame = self.frame //take the whole frame
                player?.play()
                //just when the video is ready to be run and rendering frames
                player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
                
                //track the time progress of the video
                let interval = CMTime(value: 1, timescale: 2)
                player?.addPeriodicTimeObserver(forInterval: interval, queue:  DispatchQueue.main, using: { (progressTime) in
                    let seconds = CMTimeGetSeconds(progressTime)
                    let secondsTillMin =  seconds < 60 ? seconds : seconds - 60 * (seconds / 60)
                    let secondsString = String(format: "%02d", Int(secondsTillMin))
                    let minutesString = String(format: "%02d", Int(seconds / 60))
                    self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                    
                    //move the slider of the video
                    
                    if let duration = self.player?.currentItem?.duration {
                        let durationSeconds = CMTimeGetSeconds(duration )
                        self.videoslider.value = Float(seconds / durationSeconds)
                    }
                })
            }
        }
    
         //just when the video is ready to be run and rendering frames
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            pausePlayButton.isHidden = false
            isPlaying = true
            activityIndicator.stopAnimating() //when the video is loaded remove the spinner
            controlsContainerView.backgroundColor = UIColor.clear//remove the black color

            if let duration = player?.currentItem?.duration {
              let seconds = CMTimeGetSeconds(duration)
            
               //to make it in mins
              
              let secondsText = String(format: "%02d", seconds - (seconds / 60) * 60)
              let  minutesText = String(format: "%02d", Int(seconds) / 60)
              videoLengthLabel.text = "\(minutesText): \(secondsText)"
            }
        }
    }
    //gradient makes a new color on the view
    func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.locations = [0.7, 1.2]
            //bounds specify the whole area, frame shows where to start
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor ]
            controlsContainerView.layer.addSublayer(gradientLayer)
        }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

