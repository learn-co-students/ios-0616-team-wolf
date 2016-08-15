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
import ChameleonFramework

class MatchingViewController: UIViewController {
    
    let store = LocationsDataStore.sharedInstance
    var matchingView: KolodaView!
    
    var positiveMatchParameters = [String]()
    var negativeMatchParameters = [String]()

    let matchingKeys = ["City",
                        "Country",
                        "Mountains",
                        "Beaches",
                        "Shopping",
                        "Outdoors",
                        "Sightseeing",
                        "Nightlife",
                        "Historic",
                        "Modern",
                        "Food",
                        "Fitness",
                        "Luxury",
                        "Adventure"]
    
    let matchingIcons: [UIImage] = [cityImage, countryImage, mountainsImage, beachesImage, shoppingImage, outdoorsImage, sightseeingImage, nightlifeImage, historicImage, modernImage, foodieImage, fitnessImage, luxuryImage, adventureImage]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Color count: \(colorArray.count)")
        
        configureMatchingView()
        
        self.view.backgroundColor = softWhite
    }
    
    
    func configureMatchingView() {
        matchingView = KolodaView()
        view.addSubview(matchingView)
        matchingView.translatesAutoresizingMaskIntoConstraints = false
        matchingView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        matchingView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        matchingView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.85).active = true
        matchingView.heightAnchor.constraintEqualToAnchor(matchingView.widthAnchor, multiplier: 1.1).active = true
        
        matchingView.dataSource = self
        matchingView.delegate = self

        matchingView.layer.shadowRadius = 4
        matchingView.layer.shadowOpacity = 0.5
        matchingView.layer.borderColor = teal.CGColor
        matchingView.layer.borderWidth = 6
    }
}



extension MatchingViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(matchingView: KolodaView) {
        
        // Initialize and run the LocationMatchmaker based on the matching parameters.
        let matcher = LocationMatchmaker.init(positiveMatchParameters: positiveMatchParameters, negativeMatchParameters: negativeMatchParameters)
        matcher.tallyPositiveLocationMatches()
        matcher.tallyNegativeLocationMatches()
        matcher.sortLocationsByMatchCount()
        matcher.returnMatchedLocations()
        
        print("These are all the locations:\n")
        for location in store.locations {
            print("Name: \(location.name)")
            print("Match Count: \(location.matchCount)\n")
        }
        
        print("These are the matched locations:\n")
        for location in store.matchedLocations {
            print("Name: \(location.name)")
            print("Match Count: \(location.matchCount)\n")
        }
        
        CoordinateAndFlightQueues.getCoordinatesAndFlightInfo()
        
        self.performSegueWithIdentifier("loadCarousel", sender: self)
        
        // Send the matched locations to the Carousel ViewController...?
    }

    
    func koloda(koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, inDirection direction: SwipeResultDirection) {

       
    }
    
    func koloda(matchingView: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        
        print("Locations in store when \(index + 1) match card loads: \(store.locations.count)")
        
        if index % 3 == 0 {
            store.getLocationsWithCompletion({
                print("Calling get locations for the card at index \(index).")
            })
        }
        
        let matchWord = matchingKeys[Int(index)]
        
        if direction == .Left {
            negativeMatchParameters.append(matchWord)
            print("Left swipe : \(matchWord)")
            
        } else if direction == .Right {
            positiveMatchParameters.append(matchWord)
            print("Right swipe : \(matchWord)")
        }
        
        print("These words have been added to the positive matching parameters array: \(positiveMatchParameters)")
        print("These words have been added to the negative matching parameters array: \(negativeMatchParameters)")
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
        
        matchingCardView.backgroundColor = gray//periwinkle.lightenByPercentage(10000)
        
        // Add and constrain matching icon:
        let iconView = UIImageView()
        matchingCardView.addSubview(iconView)
        
        let icon = matchingIcons[Int(index)]
        iconView.image = icon
        iconView.contentMode = .ScaleAspectFill
        
        iconView.snp_makeConstraints { make in
            make.centerX.equalTo(matchingCardView)
            make.centerY.equalTo(matchingCardView).offset(-20)
            make.width.height.equalTo(225)
        }
        
        // Add and constrain matching label:
        let matchWordLabel = UILabel()
        let font = UIFont(name: "Avenir-Book", size: 45)
        matchingCardView.addSubview(matchWordLabel)
        
        matchWordLabel.text = matchingKeys[Int(index)]
        matchWordLabel.font = font
        matchWordLabel.textAlignment = .Center
        matchWordLabel.textColor = gray
        matchWordLabel.backgroundColor = mint
        
        matchWordLabel.snp_makeConstraints { make in
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(matchingCardView).offset(-10)
            make.width.equalTo(matchingCardView)
            make.height.equalTo(70)
        }
        
        return matchingCardView
    }
    

//    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
//        return NSBundle.mainBundle().loadNibNamed("OverlayView",
//                                                  owner: self, options: nil)[0] as? OverlayView
//    }
}