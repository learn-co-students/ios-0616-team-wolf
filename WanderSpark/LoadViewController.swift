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
    let favoritesStore = FavoritesDataStore.sharedInstance
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
//            let airplaneIcon = "data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTYuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjY0cHgiIGhlaWdodD0iNjRweCIgdmlld0JveD0iMCAwIDUxMCA1MTAiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMCA1MTA7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8ZyBpZD0iYWlycGxhbmVtb2RlLW9uIj4KCQk8cGF0aCBkPSJNNDk3LjI1LDM1N3YtNTFsLTIwNC0xMjcuNVYzOC4yNUMyOTMuMjUsMTcuODUsMjc1LjQsMCwyNTUsMGMtMjAuNCwwLTM4LjI1LDE3Ljg1LTM4LjI1LDM4LjI1VjE3OC41TDEyLjc1LDMwNnY1MSAgICBsMjA0LTYzLjc1VjQzMy41bC01MSwzOC4yNVY1MTBMMjU1LDQ4NC41bDg5LjI1LDI1LjV2LTM4LjI1bC01MS0zOC4yNVYyOTMuMjVMNDk3LjI1LDM1N3oiIGZpbGw9IiNkOTQxMDAiLz4KCTwvZz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K"
//            let airplaneData = NSData(base64EncodedString: airplaneIcon)
//            progressLine.lineCap.appendContentsOf(airplaneIcon)
            
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
        circleAnimation.duration = 15.0
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
        
        UIView.animateWithDuration(2.5, animations: {
            topLabel.alpha = 0.9
            bottomLabel.alpha = 0.9
        })
    }

}
