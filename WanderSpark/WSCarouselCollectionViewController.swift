//
//  ViewController.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import FZCarousel


class WSCarouselCollectionViewController: UIViewController {
    
    let store = LocationsDataStore.sharedInstance
    @IBOutlet weak var carouselView: FZCarouselView!
    var blurEffect: UIBlurEffect!
    var dictionaryOfLocationsAndPictures: [[String : UIImage]]?
    var arrayOfStringURL: [String] = [String]()
    var arrayOfImages: [UIImage] = [UIImage]()
    var arrayOfButtons: [UIButton] = [UIButton]()
    var findDestinationButton: UIButton! = UIButton()
    var imFellingLuckyButton: UIButton! = UIButton()
    var logoView: UIImageView! = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setConstraints()
        carouselView.clipsToBounds = true
        
        self.createImagesFromURL()
        createButtons()
        setConstraints()
        
        self.prepareCarousel()
        activateBlur()
      
    }

    func createButtons(){
        //
        self.logoView.image = wanderSparkIconBW
        
        self.logoView.layer.shadowRadius = 2
        self.logoView.layer.shadowOpacity = 2
        self.logoView.layer.shadowColor = UIColor.whiteColor().CGColor
        
        
        self.findDestinationButton.setTitle("Find Destination", forState: .Normal)
        self.findDestinationButton.addTarget(self, action: #selector(WSCarouselCollectionViewController.playMatchMakerTapped), forControlEvents: .TouchUpInside)
       // self.findDestinationButton.setBackgroundImage(backgroundButton, forState: .Normal)
        self.findDestinationButton.layer.shadowRadius = 2
        self.findDestinationButton.layer.shadowOpacity = 2
        
        self.imFellingLuckyButton.setTitle("I'm Feeling Lucky", forState: .Normal)
        self.imFellingLuckyButton.titleLabel?.font = UIFont(name: "Helvetica-Nue", size: 20)
        self.imFellingLuckyButton.addTarget(self, action: #selector(WSCarouselCollectionViewController.imFeelingLuckyTapped), forControlEvents: .TouchUpInside)
       
        
        // self.imFellingLuckyButton.setBackgroundImage(backgroundButton, forState: .Normal)
        self.imFellingLuckyButton.layer.shadowRadius = 2
        self.imFellingLuckyButton.layer.shadowOpacity = 2

    }
    
    func playMatchMakerTapped(){
        self.performSegueWithIdentifier("playMatchMaker", sender: self)
    }
    
    func imFeelingLuckyTapped(){
        self.performSegueWithIdentifier("imFeelingLucky", sender: self)
    }
    
    func createImagesFromURL(){
         // append images from assets
        arrayOfImages.append(carousel3)
        arrayOfImages.append(carousel4)
        arrayOfImages.append(carousel5)
        arrayOfImages.append(japan)
        arrayOfImages.append(china)
        arrayOfImages.append(india)
        arrayOfImages.append(egypt)
        arrayOfImages.append(brazil)
        arrayOfImages.append(carousel1)
        arrayOfImages.append(carousel2)
        
        
        arrayOfStringURL.append("https://www.nytimes.com/images/2016/08/07/travel/07HOURS1/07HOURS1-master1050.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/07/31/travel/31HOURS-PORTLAND4/31HOURS-PORTLAND4-master1050.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/07/24/travel/24HOURS1/24HOURS1-jumbo.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/06/05/travel/05HOURS-CHICAGO1_LISTY/05HOURS-CHICAGO1_LISTY-jumbo.jpg")
        
        
        for urlString in arrayOfStringURL{
            let url = NSURL(string: urlString)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            let imageFromURL = UIImage(data: data!)
            arrayOfImages.append(imageFromURL!)
  
        }
       
 
    }
    
    func activateBlur(){
        self.blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        view.addSubview(blurEffectView)
        blurEffectView.alpha = 0.5
        
        
        carouselView.addSubview(blurEffectView)
        self.carouselView.bringSubviewToFront(self.findDestinationButton)
        self.carouselView.bringSubviewToFront(self.imFellingLuckyButton)
        self.carouselView.bringSubviewToFront(self.logoView)
    }
    
    func prepareCarousel(){
        carouselView.buttonArray = arrayOfButtons
        carouselView.imageArray = arrayOfImages
        carouselView.crankInterval = 3.0
        carouselView.beginCarousel()
    
    }
    func setConstraints() {
//       self.view.removeConstraints(self.view.constraints)
//        self.carouselView.removeConstraints(self.carouselView.constraints)
//
//        self.view.translatesAutoresizingMaskIntoConstraints = false
//        self.carouselView.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.carouselView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
//        self.carouselView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
//        self.carouselView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
//        self.carouselView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.carouselView.addSubview(findDestinationButton)
        self.findDestinationButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.findDestinationButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.findDestinationButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.findDestinationButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.1).active = true
        self.findDestinationButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        
        
       
        
        self.carouselView.addSubview(imFellingLuckyButton)
        self.imFellingLuckyButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.imFellingLuckyButton.topAnchor.constraintEqualToAnchor(self.findDestinationButton.bottomAnchor, constant: 50).active = true
        self.imFellingLuckyButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        self.imFellingLuckyButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.1).active = true
        self.imFellingLuckyButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        
        self.carouselView.addSubview(logoView)
        self.logoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.logoView.bottomAnchor.constraintEqualToAnchor(self.findDestinationButton.topAnchor, constant: -50).active = true
        self.logoView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        self.logoView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.2).active = true
        self.logoView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.7).active = true
        self.logoView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 50).active = true
        
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}











//        print("prepare for carousel being called!")
//        for location in store.locations{
//
//            for locationString in location.images{
//                let url = NSURL(string: "http://www.nytimes.com/\(locationString)")
//                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//                let imageFromURL = UIImage(data: data!)
//                var myDictionary:[String : UIImage] = [String : UIImage]()
//
//                myDictionary[location.name] = imageFromURL
//                dictionaryOfLocationsAndPictures?.append(myDictionary)
//
//            }
//        }





