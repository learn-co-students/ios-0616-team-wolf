//
//  MatchingViewController.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import UIKit
import Koloda
import SnapKit

class MatchingViewController: UIViewController {
    @IBOutlet weak var matchingView: KolodaView!
    
    var matchParameters = [String]()

    let matchingKeys = [("City", "Country"),
                        ("Mountains", "Beaches"),
                        ("Shopping", "Outdoors"),
                        ("Sightseeing", "Nightlife"),
                        ("Historic", "Modern"),
                        ("Food", "Fitness"),
                        ("Luxury", "Adventure")]
    
    // Zain: Please populate these with icons made in Sketch. Needs to be in the same order as matchingKeys above, as tuples.
    let matchingIcons = [(UIImage, UIImage)]()
    let leftArrow = UIImage()
    let rightArrow = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchingView.dataSource = self
        matchingView.delegate = self
    }
}

extension MatchingViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(matchingView: KolodaView) {
        // Initialize and run the LocationMatchmaker based on the matching parameters.
        let matcher = LocationMatchmaker.init(matchParameters: matchParameters)
        matcher.tallyLocationMatches()
        matcher.sortLocationsByMatchCount()
        matcher.returnMatchedLocations()
        
        // Send the matched locations to the Carousel ViewController...?
    }
    
    
    func koloda(matchingView: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        
        if direction == .Left {
            let matchWord = matchingKeys[Int(index)].0
            matchParameters.append(matchWord)
            
        } else if direction == .Right {
            let matchWord = matchingKeys[Int(index)].1
            matchParameters.append(matchWord)
        }
        
        // Does this also need to present the next card or is that automatically built into Koloda?
    }
}

extension MatchingViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(matchingView: KolodaView) -> UInt {
        return UInt(matchingKeys.count)
    }
    
    func koloda(matchingView: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
        // MatchingCardView should be subclass of UIView rather than doing all the configuration here.
        let matchingCardView = UIView()
        
        // Add and constrain matching icons:
        let iconViewOne = UIImageView()
        let iconViewTwo = UIImageView()
        
        let iconOne = matchingIcons[Int(index)].0
        let iconTwo = matchingIcons[Int(index)].1
        
        iconViewOne.image = iconOne
        iconViewTwo.image = iconTwo
        
        iconViewOne.contentMode = .ScaleAspectFill // Zain: ScaleAspectFill is correct, as as long as you make the icons square which is the aspect ratio that I use in the constraints. If you use a different aspect ratio, use ScaleAspectFit.
        iconViewTwo.contentMode = .ScaleAspectFill
        
        // Zain: Please adjust inset/offset amounts when adding this to Storyboard. Uncertain whether inset moves in negative direction, offset in positive direction?
        iconViewOne.snp_makeConstraints { make in
            make.centerX.equalTo(matchingCardView).inset(50)
            make.centerY.equalTo(matchingCardView).inset(50)
            make.width.height.equalTo(100)
        }
        
        iconViewTwo.snp_makeConstraints { make in
            make.centerX.equalTo(matchingCardView).offset(50)
            make.centerY.equalTo(matchingCardView).inset(50)
            make.width.height.equalTo(100)
        }
        
        // Add and constrain matching labels:
        let labelOne = UILabel()
        let labelTwo = UILabel()
        
        labelOne.text = matchingKeys[Int(index)].0
        labelTwo.text = matchingKeys[Int(index)].1
        
        labelOne.textAlignment = .Center
        labelTwo.textAlignment = .Center
        
        matchingCardView.addSubview(labelOne)
        matchingCardView.addSubview(labelTwo)
        
        labelOne.snp_makeConstraints { make in
            make.centerX.equalTo(iconViewOne)
            make.top.equalTo(iconViewOne.snp_bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        labelTwo.snp_makeConstraints { make in
            make.centerX.equalTo(iconViewTwo)
            make.top.equalTo(iconViewTwo.snp_bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        // Add and constrain arrows:
        let arrowViewOne = UIImageView()
        let arrowViewTwo = UIImageView()
        
        arrowViewOne.image = leftArrow
        arrowViewTwo.image = rightArrow
        
        arrowViewOne.contentMode = .ScaleAspectFit // Zain: I used Fit instead of Fill here, because it's not a square and may be harder to match the aspect ratio you use in Sketch to the aspect ratio in the constraints.
        arrowViewTwo.contentMode = .ScaleAspectFit
        
        arrowViewOne.snp_makeConstraints { make in
            make.centerX.equalTo(iconViewOne)
            make.top.equalTo(labelOne.snp_bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        labelTwo.snp_makeConstraints { make in
            make.centerX.equalTo(iconViewTwo)
            make.top.equalTo(labelTwo.snp_bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        return matchingCardView
    }
    
    // Do not know if we need this...
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}