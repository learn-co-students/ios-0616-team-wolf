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
    
    var matchingView: KolodaView!
    
    var matchParameters = [String]()

    let matchingKeys = [("City", "Country"),
                        ("Mountains", "Beaches"),
                        ("Shopping", "Outdoors"),
                        ("Sightseeing", "Nightlife"),
                        ("Historic", "Modern"),
                        ("Food", "Fitness"),
                        ("Luxury", "Adventure")]
    
    let matchingIcons: [(UIImage, UIImage)] = [(cityImage, countryImage), (mountainsImage, beachesImage), (shoppingImage, outdoorsImage), (sightseeingImage, nightlifeImage), (historicImage, modernImage), (foodieImage, fitnessImage), (luxuryImage, adventureImage)]
//    let leftArrow: UIImage = leftArrowImage
//    let rightArrow: UIImage = rightArrowImage
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchingView = KolodaView()
        self.view.addSubview(matchingView)
        self.matchingView.translatesAutoresizingMaskIntoConstraints = false
        self.matchingView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.matchingView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.matchingView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.85).active = true
        self.matchingView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.75).active = true
       
        
         self.view.backgroundColor = UIColor.darkGrayColor()
        
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

    
    func koloda(koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, inDirection direction: SwipeResultDirection) {

       
    }
    
    func koloda(matchingView: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        
        if direction == .Left {
            let matchWord = matchingKeys[Int(index)].1
            matchParameters.append(matchWord)
            print("Left swipe : \(matchWord)")
            
        } else if direction == .Right {
            let matchWord = matchingKeys[Int(index)].0
            matchParameters.append(matchWord)
            print("Right swipe : \(matchWord)")
        }
        print("These words have been added to the matching parameters array: \(matchParameters)")
        // Does this also need to present the next card or is that automatically built into Koloda?
    }
}

extension MatchingViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(matchingView: KolodaView) -> UInt {
        return UInt(matchingIcons.count)
    }
    
    func koloda(matchingView: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
        // MatchingCardView should be subclass of UIView rather than doing all the configuration here.
        let matchingCardView = UIView()
        
        matchingCardView.backgroundColor = UIColor.whiteColor()
        
        // Add and constrain matching icons:
        let iconViewOne = UIImageView()
        let iconViewTwo = UIImageView()
        
        matchingCardView.addSubview(iconViewOne)
        matchingCardView.addSubview(iconViewTwo)
        
        let iconOne = matchingIcons[Int(index)].0
        let iconTwo = matchingIcons[Int(index)].1
        
        iconViewOne.image = iconOne
        iconViewTwo.image = iconTwo
        
        iconViewOne.contentMode = .ScaleAspectFill
        iconViewTwo.contentMode = .ScaleAspectFill

        iconViewOne.snp_makeConstraints { make in
            make.left.equalTo(matchingCardView).inset(10)
            make.centerY.equalTo(matchingCardView).offset(-20)
            make.width.height.equalTo(175)
        }
        
        iconViewTwo.snp_makeConstraints { make in
            make.right.equalTo(matchingCardView).inset(10)
            make.centerY.equalTo(matchingCardView).offset(-20)
            make.width.height.equalTo(175)
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
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        labelTwo.snp_makeConstraints { make in
            make.centerX.equalTo(iconViewTwo)
            make.top.equalTo(iconViewTwo.snp_bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        // Add and constrain arrows:
//        let arrowViewOne = UIImageView()
//        let arrowViewTwo = UIImageView()
//        
//        matchingCardView.addSubview(arrowViewOne)
//        matchingCardView.addSubview(arrowViewTwo)
//        
//        arrowViewOne.image = leftArrow
//        arrowViewTwo.image = rightArrow
//        
//        arrowViewOne.contentMode = .ScaleAspectFit // Zain: I used Fit instead of Fill here, because it's not a square and may be harder to match the aspect ratio you use in Sketch to the aspect ratio in the constraints.
//        arrowViewTwo.contentMode = .ScaleAspectFit
//        
//        arrowViewOne.snp_makeConstraints { make in
//            make.centerX.equalTo(iconViewOne)
//            make.top.equalTo(labelOne.snp_bottom).offset(20)
//            make.width.equalTo(60)
//            make.height.equalTo(25)
//        }
//        
//        arrowViewTwo.snp_makeConstraints { make in
//            make.centerX.equalTo(iconViewTwo)
//            make.top.equalTo(labelTwo.snp_bottom).offset(20)
//            make.width.equalTo(60)
//            make.height.equalTo(25)
//        }
        
        return matchingCardView
    }
    
    // Do not know if we need this...
//    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
//        return NSBundle.mainBundle().loadNibNamed("OverlayView",
//                                                  owner: self, options: nil)[0] as? OverlayView
//    }
}