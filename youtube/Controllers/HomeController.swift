//
//  ViewController.swift
//  youtube
//
//  Created by Dilyana Yankova on 7/3/18.
//  Copyright © 2018 Dilyana Yankova. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let titles = ["Home","Trending","Subscriptions","Accounts"]//for the settings Bar
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        
        //to be able to change title position - set a label
        let titleViewLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleViewLbl.text = "Home"
        titleViewLbl.textColor = UIColor.white
        titleViewLbl.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleViewLbl
        
        setupCollectionView()
        //menubar + navigationbar (navigationItem)
        setupMenuBar()//down
        setupNavBarButtons()//up
    }
    
    func setupCollectionView(){
        //scroll btw.tabs horizontally!!!
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0 //no gaps when scrolling
        }
    
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        //to scroll the view under the nav bar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        //when scroll to be into pages 1, 2, 3, 4
        collectionView?.isPagingEnabled = true
    }
      func  setupNavBarButtons() {
        //as we still don't have functionality for search
//        let searchImage = UIImage(named: "search-")?.withRenderingMode(.alwaysOriginal)
//        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMoreButton))
//        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
        navigationItem.rightBarButtonItem = moreButton
        
    }

    lazy var settingsLauncher: SeetingsLauncher = {
        let settingsLauncher = SeetingsLauncher()
        //instantiate the homecontroller just once to be able to use it in the SettingsLauncherController
        settingsLauncher.homeController = self
        return settingsLauncher
    }()
    
    @objc func handleSearch() {
 // add functionality
    }

    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        //when changing the tab - title changes from 1..4 index of the titles
        setTitleForIndex(index: menuIndex)
    }
    
    @objc func handleMoreButton() {
        settingsLauncher.homeController = self
        //show menu
        settingsLauncher.showSettings()
    }
    //open new dummycontroller for a setting
    func showControllerForSetting(setting: Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue //name of navItem
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white] as [NSAttributedStringKey : Any]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    func setTitleForIndex(index: Int){
        //when changing the tab - title changes from 1..4 index of the titles
        if let titleLable =  navigationItem.titleView as? UILabel {
            titleLable.text = titles[index]
      }
    }
    //in a block
   lazy var menuBar: MenuBar = {
        let mb = MenuBar()//cell
        mb.homeController = self // we need to make homeController point to self in order not to ne nil in MenuBar class
        return mb
    }()
    
     func setupMenuBar() {
        //to hide when we scrolldown
        navigationController?.hidesBarsOnSwipe = true
        //not to have gap after scrolling we put a red uiview on the whole bar
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32 , blue: 31, alpha: 1)
        view.addSubview(redView)//under menubar
        view.addConstraintsWithFotmat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFotmat(format: "V:[v0(50)]", views: redView)
        view.addSubview(menuBar)
        view.addConstraintsWithFotmat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFotmat(format: "V:[v0(50)]", views: menuBar)
        //when we scroll not to cut the icons of menubar
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //when scrolling horizontally move also the white menuBar line using its constraint for x
        menuBar.horizontalBarLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    //change title of bar
    //find the target of the collectionview to scroll
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //view.frame.width - the width of the entire screen 375
        //targetContentOffset.pointee.x is 0 ; 375 ; 750 ; 1150
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath =  NSIndexPath(item: Int(index), section: 0)
        //we have the index where should be selected
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        //when scroll the tab - title changes from 1..4 index of the titles
        setTitleForIndex(index: Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    //chose which cell for which tab!
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        //4 is like 1
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            identifier = subscriptionCellId
        } else  {
            identifier = cellId
        }
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50) //-50 size of the menuBar
    }
   
}

