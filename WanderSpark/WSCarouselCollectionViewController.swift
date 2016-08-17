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
    var arrayOfImages = [carousel3, japan, carousel4, china, carousel1, egypt, brazil]
    var arrayOfGrayscaleImages: [UIImage] = [UIImage]()
    var findDestinationButton: UIButton! = UIButton()
    var imFeelingLuckyButton: UIButton! = UIButton()
    var logoView: UIImageView! = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carouselView.clipsToBounds = true
        
        convertImagesToGrayscale()
        createButtons()
        setConstraints()
        
        self.prepareCarousel()
        activateBlur()
    }

    func createButtons(){
        self.logoView.image = UIImage(named: "crystalballnobackground")
        logoView.contentMode = .ScaleAspectFit
        
        self.findDestinationButton.setTitle("Find Destination", forState: .Normal)
        self.findDestinationButton.titleLabel?.font = wanderSparkFont(22)
        self.findDestinationButton.addTarget(self, action: #selector(WSCarouselCollectionViewController.playMatchMakerTapped), forControlEvents: .TouchUpInside)
        //self.findDestinationButton.setBackgroundImage(backgroundButton, forState: .Normal)
        //self.findDestinationButton.layer.shadowRadius = 2
        //self.findDestinationButton.layer.shadowOpacity = 2
        
        self.imFeelingLuckyButton.setTitle("I'm Feeling Lucky", forState: .Normal)
        self.imFeelingLuckyButton.titleLabel?.font = wanderSparkFont(22)
        self.imFeelingLuckyButton.addTarget(self, action: #selector(WSCarouselCollectionViewController.imFeelingLuckyTapped), forControlEvents: .TouchUpInside)
        
        //self.imFeelingLuckyButton.setBackgroundImage(backgroundButton, forState: .Normal)
        //self.imFeelingLuckyButton.layer.shadowRadius = 2
        //self.imFeelingLuckyButton.layer.shadowOpacity = 2
    }
    
    func playMatchMakerTapped(){
        self.performSegueWithIdentifier("playMatchMaker", sender: self)
    }
    
    func imFeelingLuckyTapped(){
        self.performSegueWithIdentifier("imFeelingLucky", sender: self)
    }
    
    func convertImagesToGrayscale() {
        arrayOfGrayscaleImages = arrayOfImages.map { convertToGrayScale($0) }
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
        self.carouselView.bringSubviewToFront(self.imFeelingLuckyButton)
        self.carouselView.bringSubviewToFront(self.logoView)
    }
    
    func prepareCarousel(){
        carouselView.imageArray = arrayOfGrayscaleImages
        carouselView.crankInterval = 1.5
        carouselView.beginCarousel()
    }
    
    func setConstraints() {
        self.carouselView.addSubview(logoView)
        self.logoView.translatesAutoresizingMaskIntoConstraints = false
        self.logoView.bottomAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.logoView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.logoView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.35).active = true
        self.logoView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.7).active = true
        
        self.carouselView.addSubview(findDestinationButton)
        self.findDestinationButton.translatesAutoresizingMaskIntoConstraints = false
        self.findDestinationButton.topAnchor.constraintEqualToAnchor(self.logoView.bottomAnchor, constant: 100).active = true
        self.findDestinationButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.findDestinationButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.1).active = true
        self.findDestinationButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        
        self.carouselView.addSubview(imFeelingLuckyButton)
        self.imFeelingLuckyButton.translatesAutoresizingMaskIntoConstraints = false
        self.imFeelingLuckyButton.topAnchor.constraintEqualToAnchor(self.findDestinationButton.bottomAnchor, constant: 10).active = true
        self.imFeelingLuckyButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.imFeelingLuckyButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.1).active = true
        self.imFeelingLuckyButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertToGrayScale(image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        CGContextDrawImage(context, imageRect, image.CGImage)
        let imageRef = CGBitmapContextCreateImage(context)
        let newImage = UIImage(CGImage: imageRef!)
        
        return newImage
    }

}
