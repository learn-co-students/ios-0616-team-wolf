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

    let matchingKeys = [("City", "Country"),
                        ("Mountains", "Beaches"),
                        ("Shopping", "Outdoors"),
                        ("Sightseeing", "Nightlife"),
                        ("Historic", "Modern"),
                        ("Food", "Fitness"),
                        ("Luxury", "Adventure")]
    
    // Zain will populate this with icons made in Sketch. Needs to be in the same order as matchingKeys above, as tuples.
    
    // Should we combine this with the matchingKeys in a dictionary somehow? Or maybe add everything to the matching dictionary in LocationMatchmaker class?
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
        // Present the Carousel ViewController based on the matching parameters.
        
    }
    
    func koloda(matchingView: KolodaView, didSelectCardAtIndex index: UInt) {
        // Store the matching parameter in the matchmaker array.
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
        
        // Zain to adjust inset/offset amounts when adding this to Storyboard. Uncertain whether inset moves in negative direction, offset in positive direction?
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
        
        

        
        return matchingCardView
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}