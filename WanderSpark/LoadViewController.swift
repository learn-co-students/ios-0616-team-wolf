//
//  LoadViewController.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/15/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework
import NVActivityIndicatorView

class LoadViewController: UIViewController {
    let store = LocationsDataStore.sharedInstance
    let favoritesStore = FavoritesDataStore.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = lightMagentaGradient(self.view.frame)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            
            self.configureGlobe()
            self.configureWanderText()
            
            let airplaneActivityIndicatorView = NVActivityIndicatorView(frame: self.view.frame,
                type: .Orbit, padding: 0.0)
            let airplaneAnimationTypeLabel = UILabel(frame: self.view.frame)
            airplaneActivityIndicatorView.padding = 0.0
            airplaneActivityIndicatorView.alpha = 1.0
            self.view.addSubview(airplaneActivityIndicatorView)
            self.view.addSubview(airplaneAnimationTypeLabel)
            
            let bubbleActivityIndicatorView = NVActivityIndicatorView(frame: self.view.frame,
                type: .BallScale, padding: 0.0)
            let bubbleAnimationTypeLabel = UILabel(frame: self.view.frame)
            bubbleActivityIndicatorView.padding = 0.0
            bubbleActivityIndicatorView.color = UIColor.flatPowderBlueColor()
            bubbleActivityIndicatorView.alpha = 0.3
            self.view.addSubview(bubbleActivityIndicatorView)
            self.view.addSubview(bubbleAnimationTypeLabel)
            
            airplaneActivityIndicatorView.startAnimation()
            bubbleActivityIndicatorView.startAnimation()
        }
        
        CoordinateAndFlightQueues.getCoordinatesAndFlightInfo({ (complete) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                let destinationVC = VacationCollectionView()
                self.presentViewController(destinationVC, animated: true
                    , completion: {
                        
                })
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
    
    
    func configureGlobe() {
        let globe = UIImage(named: "earth.png")
        let tintedGlobe = globe!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let globeImageView = UIImageView(image: tintedGlobe)
        globeImageView.tintColor = UIColor.flatGreenColorDark()
        view.addSubview(globeImageView)
        globeImageView.contentMode = .ScaleAspectFill
        
        globeImageView.snp_makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(view.snp_height).multipliedBy(0.35)
            make.width.equalTo(view.snp_width).multipliedBy(0.55)
        }
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
