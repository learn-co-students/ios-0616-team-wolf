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
    var matchingView = KolodaView()
    
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
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMatchingView()
        configureIconScrollView()
        configureIconStackView()
        configureYesButton()
        configureNoButton()
        
        self.view.backgroundColor = orangeGradient(view.frame)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        iconScrollView.frame = CGRectMake(0, 60, view.frame.width, view.frame.height/10)
        iconStackView.frame = CGRectMake(0, 0, iconScrollView.contentSize.width, iconScrollView.contentSize.height)
    }
    
    
    func configureMatchingView() {
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
        iconScrollView.pagingEnabled = true
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
            let iconImageView = makeIconImageView(icon)
            makeIconButton(iconImageView)
            iconStackView.addArrangedSubview(iconImageView)
        }
    }
    
    
    func makeIconImageView(icon: UIImage) -> UIImageView {
        let tintedIcon = icon.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let iconImageView = UIImageView(image: tintedIcon)
        
        iconImageView.snp_makeConstraints { make in
            make.width.height.equalTo(60)
        }
        iconImageView.backgroundColor = UIColor.flatWhiteColor()
        iconImageView.tintColor = UIColor.flatBlackColor().lightenByPercentage(0.05)
        iconImageView.alpha = 0.25
        
        return iconImageView
    }
    
    
    func makeIconButton(iconImageView: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(iconTapped))
        iconImageView.userInteractionEnabled = true
        iconImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    func iconTapped(sender: UITapGestureRecognizer) {
        if let iconImageView = sender.view {
            if let iconStackIndex = iconStackView.arrangedSubviews.indexOf(iconImageView) {
                print("Icon at index \(iconStackIndex) tapped.")
                
                while matchingView.currentCardIndex > iconStackIndex {
                    matchingView.revertAction()
                    matchingView.applyAppearAnimationIfNeeded()
                }
            }
        }
    }

    
// MARK: Buttons
    
    func configureYesButton() {
        view.addSubview(yesButton)
        yesButton.setTitle("✔︎", forState: UIControlState.Normal)
        yesButton.backgroundColor = UIColor.flatGreenColorDark()
        yesButton.layer.cornerRadius = 2
        yesButton.titleLabel?.font = wanderSparkFont(35)
    
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
        noButton.titleLabel?.font = wanderSparkFont(30)
        
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
        
        self.performSegueWithIdentifier("loadViewController", sender: self)

        // Send the matched locations to the Carousel ViewController...?
    }
    
    
    func koloda(matchingView: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        
        // Make call to the NYTimes API when the first card loads.
        if index == 0 {
            store.getLocationsWithCompletion({
            })
        }
        
        let matchWord = matchingKeys[Int(index)]
        let icon = iconStackView.arrangedSubviews[Int(index)]
        
        // Trying to animate scroll view so that each icon moves over as card is selected...
        // iconScrollView.contentInset.left = iconScrollView.contentInset.left - (icon.frame.size.width + CGFloat(2))
        let width = iconScrollView.frame.width
        let height = iconScrollView.frame.height
        let newPosition = iconScrollView.contentOffset.x + icon.frame.width
        let toVisible = CGRectMake(newPosition, 0, width, height)
        iconScrollView.scrollRectToVisible(toVisible, animated: true)
        
        if direction == .Left {
            negativeMatchParameters = addMatchWordToParameters(negativeMatchParameters, matchWord: matchWord)
            icon.backgroundColor = UIColor.flatRedColorDark()
            print("Left swipe : \(matchWord)")
            
        } else if direction == .Right {
            positiveMatchParameters = addMatchWordToParameters(positiveMatchParameters, matchWord: matchWord)
            icon.backgroundColor = UIColor.flatGreenColor()
            icon.alpha = 0.55
            print("Right swipe : \(matchWord)")
        }
        
        print("These words have been added to the positive matching parameters array: \(positiveMatchParameters)")
        print("These words have been added to the negative matching parameters array: \(negativeMatchParameters)")
    }
    
    func addMatchWordToParameters(parameters: [String], matchWord: String) -> [String] {
        var parameters = parameters
        
        if let matchWordIndex = positiveMatchParameters.indexOf(matchWord) {
            positiveMatchParameters.removeAtIndex(matchWordIndex)
        }
        
        if let matchWordIndex = negativeMatchParameters.indexOf(matchWord) {
            negativeMatchParameters.removeAtIndex(matchWordIndex)
        }
        parameters.append(matchWord)
        return parameters
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
        
        // Add and constrain matching label:
        let matchWordLabel = UILabel()
        let font = UIFont(name: "Avenir-Book", size: 45)
        matchingCardView.addSubview(matchWordLabel)
        
        matchWordLabel.text = matchingKeys[Int(index)]
        matchWordLabel.font = font
        matchWordLabel.textAlignment = .Center
        matchWordLabel.textColor = UIColor.flatWhiteColor()
        matchWordLabel.backgroundColor = UIColor.flatPlumColorDark().darkenByPercentage(0.1)
        
        matchWordLabel.snp_makeConstraints { make in
            make.centerX.equalTo(matchingCardView)
            make.bottom.equalTo(matchingCardView).offset(-5)
            make.width.equalTo(matchingCardView)
            make.height.equalTo(70)
        }
        
        // Add and constrain matching icon:
        let iconView = UIImageView()
        matchingCardView.addSubview(iconView)
        
        let icon = matchingIcons[Int(index)]
        iconView.image = icon
        iconView.contentMode = .ScaleAspectFill
        
        iconView.snp_makeConstraints { make in
            make.centerX.equalTo(matchingCardView)
            make.bottom.equalTo(matchWordLabel.snp_top).offset(-5)
            make.width.height.equalTo(matchingCardView).multipliedBy(0.7)
        }

        return matchingCardView
    }
}
