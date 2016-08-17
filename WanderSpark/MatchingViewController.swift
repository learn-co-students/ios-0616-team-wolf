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
    
    let iconStackView = UIStackView()
    let iconScrollView = UIScrollView()
    let yesButton = UIButton()
    let noButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMatchingView()
        configureIconScrollView()
        configureIconStackView()
        configureYesButton()
        configureNoButton()
        
        let gradientColor = UIColor(gradientStyle:UIGradientStyle.Radial, withFrame:view.frame, andColors:[UIColor.flatYellowColor(), UIColor.flatRedColor()])
        self.view.backgroundColor = gradientColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        iconScrollView.frame = CGRectMake(0, 60, view.frame.width, view.frame.height/10)
        iconStackView.frame = CGRectMake(0, 0, iconScrollView.contentSize.width, iconScrollView.contentSize.height)
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
        matchingView.layer.shadowOpacity = 0.35
        matchingView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
// MARK: Icon Scroll View
    
    func configureIconScrollView() {
        iconScrollView.contentSize = CGSizeMake(860, iconStackView.frame.height)
        iconScrollView.alwaysBounceHorizontal = false
        iconScrollView.showsHorizontalScrollIndicator = false
        iconScrollView.addSubview(iconStackView)
        view.addSubview(iconScrollView)
        
        iconScrollView.snp_remakeConstraints { (make) in
            make.top.equalTo(view)
        }
    }
    
    
    func configureIconStackView() {
        iconStackView.axis = .Horizontal
        iconStackView.distribution = .FillEqually
        iconStackView.alignment = .Center
        iconStackView.spacing = 2
        
        iconStackView.snp_makeConstraints { make in
            make.left.equalTo(iconScrollView)
            make.top.equalTo(iconScrollView)
            make.width.equalTo(iconScrollView)
            make.height.equalTo(iconScrollView)
        }
        
        for icon in matchingIcons {
            let tintedIcon = icon.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            let iconImageView = UIImageView(image: tintedIcon)
            
            iconImageView.snp_makeConstraints { make in
                make.width.height.equalTo(60)
            }
            iconImageView.backgroundColor = UIColor.flatWhiteColor()
            iconImageView.tintColor = UIColor.flatBlackColor().lightenByPercentage(0.05)
            iconImageView.alpha = 0.25
            iconStackView.addArrangedSubview(iconImageView)
        }
    }
    
// MARK: Buttons
    
    func configureYesButton() {
        view.addSubview(yesButton)
        yesButton.setTitle("✔︎", forState: UIControlState.Normal)
        yesButton.backgroundColor = UIColor.flatGreenColorDark()
        yesButton.layer.cornerRadius = 2
        yesButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 35)
    
        yesButton.snp_makeConstraints { make in
            make.right.equalTo(matchingView)
            make.top.equalTo(matchingView.snp_bottom).offset(20)
            make.width.equalTo(matchingView).multipliedBy(0.5)
            make.height.equalTo(35)
        }
        
        yesButton.addTarget(self, action: #selector(self.yesButtonTapped), forControlEvents: .TouchUpInside)
    }
    
    
    func configureNoButton() {
        view.addSubview(noButton)
        noButton.setTitle("✖︎", forState: UIControlState.Normal)
        noButton.backgroundColor = UIColor.flatRedColorDark()
        noButton.layer.cornerRadius = 2
        noButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 30)
        
        noButton.snp_makeConstraints { make in
            make.left.equalTo(matchingView)
            make.top.equalTo(matchingView.snp_bottom).offset(20)
            make.width.equalTo(matchingView).multipliedBy(0.5)
            make.height.equalTo(35)
        }
        
        noButton.addTarget(self, action:#selector(self.noButtonTapped), forControlEvents: .TouchUpInside)
    }
    
    func yesButtonTapped() {
        matchingView.swipe(.Right)
    }
    
    func noButtonTapped() {
        matchingView.swipe(.Left)
    }
    
}

// MARK: Koloda Delegate

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
        self.performSegueWithIdentifier("loadViewController", sender: self)
       
        
        
       
        // Send the matched locations to the Carousel ViewController...?
    }
    
    
    func koloda(matchingView: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        
        print("Locations in store when \(index + 1) match card loads: \(store.locations.count)")
        
        if index % 3 == 0 {
            store.getLocationsWithCompletion({
                print("Calling get locations for the card at index \(index).")
            })
        }
        
        let matchWord = matchingKeys[Int(index)]
        let icon = iconStackView.arrangedSubviews[Int(index)]
        
        /* Trying to animate scroll view so that each icon moves over as card is selected...
        let newXPoint = iconScrollView.contentOffset.x + icon.frame.size.width
        iconScrollView.setContentOffset(CGPoint(x: newXPoint, y: iconScrollView.contentOffset.y), animated: true) */
        
        if direction == .Left {
            negativeMatchParameters.append(matchWord)
            icon.backgroundColor = UIColor.flatRedColorDark()
            print("Left swipe : \(matchWord)")
            
        } else if direction == .Right {
            positiveMatchParameters.append(matchWord)
            icon.backgroundColor = UIColor.flatGreenColor()
            icon.alpha = 0.55
            print("Right swipe : \(matchWord)")
        }
        
        print("These words have been added to the positive matching parameters array: \(positiveMatchParameters)")
        print("These words have been added to the negative matching parameters array: \(negativeMatchParameters)")
    }
}

// MARK: Koloda Data Source

extension MatchingViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(matchingView: KolodaView) -> UInt {
        return UInt(matchingIcons.count)
    }
    
    func koloda(matchingView: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
        // MatchingCardView should be subclass of UIView rather than doing all the configuration here.
        let matchingCardView = UIView()
        
        matchingCardView.backgroundColor = UIColor.flatWhiteColor()
        
        // Add and constrain matching icon:
        let iconView = UIImageView()
        matchingCardView.addSubview(iconView)
        
        let icon = matchingIcons[Int(index)]
        iconView.image = icon
        iconView.contentMode = .ScaleAspectFill
        
        iconView.snp_makeConstraints { make in
            make.centerX.equalTo(matchingCardView)
            make.centerY.equalTo(matchingCardView).offset(-20)
            make.width.height.equalTo(matchingCardView).multipliedBy(0.7)
        }
        
        // Add and constrain matching label:
        let matchWordLabel = UILabel()
        let font = UIFont(name: "Avenir-Book", size: 45)
        matchingCardView.addSubview(matchWordLabel)
        
        matchWordLabel.text = matchingKeys[Int(index)]
        matchWordLabel.font = font
        matchWordLabel.textAlignment = .Center
        matchWordLabel.textColor = UIColor.flatWhiteColor()
        matchWordLabel.backgroundColor = UIColor.flatPlumColorDark().darkenByPercentage(0.2)
        
        matchWordLabel.snp_makeConstraints { make in
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(matchingCardView).offset(-5)
            make.width.equalTo(matchingCardView)
            make.height.equalTo(70)
        }
        
        return matchingCardView
    }
    

}