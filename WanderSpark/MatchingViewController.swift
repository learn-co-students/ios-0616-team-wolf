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

class MatchingViewController: UIViewController {
    @IBOutlet weak var matchingView: KolodaView!

    let matchingKeys = [("City", "Country"),
                        ("Mountains", "Beaches"),
                        ("Shopping", "Outdoors"),
                        ("Sightseeing", "Nightlife"),
                        ("Historic", "Modern"),
                        ("Food", "Fitness"),
                        ("Luxury", "Adventure")]
    
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
        return matchingKeys.count
    }
    
    func koloda(matchingView: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
        let matchingCardView = UIView()
        
        let labelOne = UILabel()
        let labelTwo = UILabel()
        
        
        return UIView()
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}