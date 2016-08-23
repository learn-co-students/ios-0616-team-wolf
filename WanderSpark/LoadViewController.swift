//
//  LoadViewController.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/15/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import SnapKit
import UICircleAnimationView
import ChameleonFramework
import NVActivityIndicatorView

class LoadViewController: UIViewController {
    var circleAnimation = UICircleAnimationView()
    let store = LocationsDataStore.sharedInstance
    let favoritesStore = FavoritesDataStore.sharedInstance
    var imFeelingLucky: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = purpleGradient(view.frame)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            
            self.configureGlobe()
            self.configureWanderText()
            
            let activityIndicatorView = NVActivityIndicatorView(frame: self.view.frame,
                type: .Orbit, padding: 0.0)
            let animationTypeLabel = UILabel(frame: self.view.frame)
            
            activityIndicatorView.padding = 0.0
            activityIndicatorView.color = UIColor.flatSkyBlueColor()
            activityIndicatorView.alpha = 0.5
            self.view.addSubview(activityIndicatorView)
            self.view.addSubview(animationTypeLabel)
            activityIndicatorView.startAnimation()
        }
        
        CoordinateAndFlightQueues.getCoordinatesAndFlightInfo({ (complete) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.performSegueWithIdentifier("presentCollectionView", sender: self)
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
//    func configureCircleAnimation() {
//        let circleAnimationFrame = CGRect(x: view.center.x/2, y: view.center.y/2, width: view.frame.width/2, height: view.frame.height/2)
//        circleAnimation = UICircleAnimationView(frame: circleAnimationFrame)
//        view.addSubview(circleAnimation)
//        
//        circleAnimation.setForegroundStrokeColor(UIColor.orangeColor())
//        circleAnimation.strokeCircleTo(19, total: 10, withAnimate: true)
//        circleAnimation.duration = 20.0
//    }
    
    
    func configureGlobe() {
        let globe = UIImage(named: "earth.png")
        let tintedGlobe = globe!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let globeImageView = UIImageView(image: tintedGlobe)
        globeImageView.tintColor = UIColor.flatGreenColor()
        view.addSubview(globeImageView)
        globeImageView.contentMode = .ScaleAspectFill
        
        globeImageView.layer.shadowOpacity = 0.75
        globeImageView.layer.shadowRadius = 3.0
        globeImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        globeImageView.snp_makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(view.snp_height).multipliedBy(0.35)
            make.width.equalTo(view.snp_width).multipliedBy(0.55)
        }
    }
    
    
//    func configurePlane() {
//        circleAnimation.circlePoint.contents = UIImage(named: "airplane")?.CGImage
//        circleAnimation.circlePoint.frame = CGRectMake(0, 0, 35, 35)
//        circleAnimation.circlePoint.borderWidth = 0
//        circleAnimation.circlePoint.cornerRadius = 18
//        //stop animation
//    }
    
    func configureWanderText() {
        
        let topLabel = UILabel()
        topLabel.text = "Prepare to"
        topLabel.textColor = UIColor.flatWhiteColor()
        topLabel.font = wanderSparkFont(40)
        topLabel.alpha = 0
        topLabel.textAlignment = .Center
        view.addSubview(topLabel)
        
        topLabel.snp_makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(90)
            make.height.equalTo(40)
            make.width.equalTo(view)
        }
        
        let bottomLabel = UILabel()
        bottomLabel.text = "Wander"
        bottomLabel.textColor = UIColor.flatWhiteColor()
        bottomLabel.font = wanderSparkFont(40)
        bottomLabel.alpha = 0
        bottomLabel.textAlignment = .Center
        view.addSubview(bottomLabel)
        
        bottomLabel.snp_makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).inset(85)
            make.height.equalTo(40)
            make.width.equalTo(view)
        }
        
        UIView.animateWithDuration(2.0, animations: {
            topLabel.alpha = 0.9
            bottomLabel.alpha = 0.9
        })
    }
    
}
