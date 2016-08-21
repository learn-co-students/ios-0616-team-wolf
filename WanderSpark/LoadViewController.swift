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

class LoadViewController: UIViewController {
    var circleAnimation = UICircleAnimationView()
    let store = LocationsDataStore.sharedInstance
    var imFeelingLucky: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = purpleGradient(view.frame)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock { 
            self.configurePlane()
            self.configureGlobe()
            self.configureWanderText()
            self.configureCircleAnimation()
            
//            // set up some values to use in the curve
//            let ovalStartAngle = CGFloat(90.01 * M_PI/180)
//            let ovalEndAngle = CGFloat(90 * M_PI/180)
//            let ovalRect = CGRectMake(97.5, 58.5, 125, 125)
//            
//            // create the bezier path
//            let ovalPath = UIBezierPath()
//            
//            ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
//                radius: CGRectGetWidth(ovalRect) / 2,
//                startAngle: ovalStartAngle,
//                endAngle: ovalEndAngle, clockwise: true)
//            
//            // create an object that represents how the curve
//            // should be presented on the screen
//            let progressLine = CAShapeLayer()
//            progressLine.path = ovalPath.CGPath
//            progressLine.strokeColor = UIColor.blueColor().CGColor
//            progressLine.fillColor = UIColor.clearColor().CGColor
//            progressLine.lineWidth = 10.0
//            progressLine.lineCap = kCALineCapRound

            
            // add the curve to the screen
//            self.view.layer.addSublayer(progressLine)
//            
//            // create a basic animation that animates the value 'strokeEnd'
//            // from 0.0 to 1.0 over 3.0 seconds
//            let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
//            animateStrokeEnd.duration = 3.0
//            animateStrokeEnd.fromValue = 0.0
//            animateStrokeEnd.toValue = 1.0
//            
//            // add the animation
//            progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
            
        }
    
        let getCoordinatesAndFlightsQueue = NSOperationQueue()
        getCoordinatesAndFlightsQueue.qualityOfService = .UserInitiated
        getCoordinatesAndFlightsQueue.addOperationWithBlock { 
            CoordinateAndFlightQueues.getCoordinatesAndFlightInfo({ (complete) in
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.performSegueWithIdentifier("presentCollectionView", sender: self)
                })
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureCircleAnimation() {
        let circleAnimationFrame = CGRect(x: view.center.x/2, y: view.center.y/2, width: view.frame.width/2, height: view.frame.height/2)
        circleAnimation = UICircleAnimationView(frame: circleAnimationFrame)
        view.addSubview(circleAnimation)
        
        circleAnimation.setForegroundStrokeColor(UIColor.orangeColor())
        circleAnimation.strokeCircleTo(19, total: 10, withAnimate: true)
    }
    
    
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
            make.height.equalTo(view.snp_height).multipliedBy(0.45)
            make.width.equalTo(view.snp_width).multipliedBy(0.65)
        }
    }
    
    
    func configurePlane() {
        circleAnimation.circlePoint.contents = UIImage(named: "airplane")?.CGImage
        circleAnimation.circlePoint.frame = CGRectMake(0, 0, 35, 35)
        circleAnimation.circlePoint.borderWidth = 0
        circleAnimation.circlePoint.cornerRadius = 18
    }
    
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
