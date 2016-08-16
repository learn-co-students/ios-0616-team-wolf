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

class LoadViewController: UIViewController {
    var circleAnimation = UICircleAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.lightGrayColor()
        
        configureCircleAnimation()
        configurePlane()
        configureGlobe()
        configureWanderText()
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
        let globe = UIImage(named: "globe.png")
        let globeImageView = UIImageView(image: globe)
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
        circleAnimation.circlePoint.contents = UIImage(named: "plane")?.CGImage
        circleAnimation.circlePoint.frame = CGRectMake(0, 0, 35, 35)
        circleAnimation.circlePoint.borderWidth = 0
        circleAnimation.circlePoint.cornerRadius = 18
    }
    
    func configureWanderText() {
        let font = UIFont (name: "AvenirNext-DemiBold", size: 40)
        
        let topLabel = UILabel()
        topLabel.text = "Prepare to"
        topLabel.font = font
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
        bottomLabel.font = font
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
