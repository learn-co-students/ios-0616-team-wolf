//
//  customeVacationCell.swift
//  
//
//  Created by Zain Nadeem on 8/10/16.
//
//

import UIKit

class customVacationCell: UICollectionViewCell, UITextViewDelegate {
    
    var blurEffectView: UIVisualEffectView!
    var backgroundLocationImage = UIImageView()
    var imageView : UIImageView!
    var circleProfileView = UIImageView()
    
    var snippetLabel = UITextView()
    var locationLabel = UILabel()
    var airportLabel = UILabel()
    var carrierLabel = UILabel()
    
    var homeButton = UIButton()
    var priceButton = UIButton()
    var readMoreButton = UIButton()
    var favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        configureBackgroundImage()
        configureBlurEffect()
        configureImageView()
        configureLocationLabel()
        configureReadMoreButton()
        configureHomeButton()
        configureFavoriteButton()
        configureCarrierLabel()
        configureAirportLabel()
        configurePriceButton()
        configureSnippetLabel()
    }
    
    
    
    
    func configureAirportLabel() {
        contentView.addSubview(airportLabel)
        
        airportLabel.font = wanderSparkFont(12)
        airportLabel.textColor = UIColor.whiteColor()
        
        self.airportLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportLabel.bottomAnchor.constraintEqualToAnchor(self.carrierLabel.topAnchor, constant: -1).active = true
        self.airportLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -20).active = true
    }
    
    
    func configureCarrierLabel() {
        contentView.addSubview(carrierLabel)
        
        carrierLabel.font = wanderSparkFont(12)
        carrierLabel.textColor = UIColor.whiteColor()
        
        self.carrierLabel.translatesAutoresizingMaskIntoConstraints = false
        self.carrierLabel.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -10).active = true
        self.carrierLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -20).active = true
    }
    
    func configureLocationLabel() {
        contentView.addSubview(locationLabel)
        
        locationLabel.font = boldWanderSparkFont(28)
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Right
        locationLabel.adjustsFontSizeToFitWidth = true
        
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.bottomAnchor.constraintEqualToAnchor(self.imageView.topAnchor, constant: -15).active = true
        self.locationLabel.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.8).active = true
        self.locationLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -15).active = true
    }
    
    
    func configureSnippetLabel() {
        contentView.addSubview(snippetLabel)
        
        self.snippetLabel.translatesAutoresizingMaskIntoConstraints = false
        self.snippetLabel.topAnchor.constraintEqualToAnchor(self.imageView.bottomAnchor, constant: 10).active = true
        self.snippetLabel.bottomAnchor.constraintEqualToAnchor(self.priceButton.topAnchor, constant: -5).active = true
        self.snippetLabel.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 15).active = true
        self.snippetLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -15).active = true
        
        snippetLabel.delegate = self
        snippetLabel.backgroundColor = UIColor.clearColor()
        snippetLabel.font = wanderSparkFont(18)
        snippetLabel.textAlignment = NSTextAlignment.Left
        snippetLabel.textColor = UIColor.whiteColor()
        snippetLabel.text = "No Information"
        
        snippetLabel.allowsEditingTextAttributes = false
        snippetLabel.userInteractionEnabled = true
        snippetLabel.scrollEnabled = false
        snippetLabel.selectable = true
    }
    
    
    func configureBackgroundImage() {
        contentView.addSubview(backgroundLocationImage)
        
        backgroundLocationImage.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundLocationImage.clipsToBounds = true
        
        self.backgroundLocationImage.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundLocationImage.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor).active = true
        self.backgroundLocationImage.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
        self.backgroundLocationImage.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        self.backgroundLocationImage.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor).active = true
    }
    
    
    func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blurEffectView.alpha = 1
        
        contentView.addSubview(blurEffectView)
    }
    
    
    func configureImageView() {
        contentView.addSubview(imageView)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor, constant: -50).active = true
        self.imageView.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
        self.imageView.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        self.imageView.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.35).active = true   
    }
    
    
    func configureReadMoreButton() {
        contentView.addSubview(readMoreButton)
        
        readMoreButton.titleLabel?.font = wanderSparkFont(16)
        readMoreButton.titleLabel?.textColor = UIColor.blueColor()
        readMoreButton.setTitle("read more", forState: .Normal)
        
        self.readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        self.readMoreButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -20).active = true
        self.readMoreButton.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 20).active = true
    }
    
    
    func configureHomeButton() {
        contentView.addSubview(homeButton)
        
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.homeButton.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 25).active = true
        self.homeButton.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 20).active = true
        
        homeButton.titleLabel?.font = wanderSparkFont(16)
        homeButton.titleLabel?.textColor = UIColor.whiteColor()
        homeButton.setTitle("home", forState: .Normal)
    }
    
    
    func configurePriceButton() {
        contentView.addSubview(priceButton)
        
        priceButton.titleLabel?.font = wanderSparkFont(40)
        priceButton.titleLabel?.textColor = UIColor.whiteColor()
        priceButton.titleLabel?.shadowColor = UIColor.whiteColor()
        
        self.priceButton.translatesAutoresizingMaskIntoConstraints = false
        self.priceButton.bottomAnchor.constraintEqualToAnchor(self.airportLabel.topAnchor, constant: -3).active = true
        self.priceButton.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant:-20).active = true
        self.priceButton.heightAnchor.constraintEqualToConstant(40).active = true
    }
    
  
    func configureFavoriteButton() {
        contentView.addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.centerYAnchor.constraintEqualToAnchor(homeButton.centerYAnchor).active = true
        favoriteButton.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -20).active = true
        
        favoriteButton.titleLabel?.font = wanderSparkFont(32)
        favoriteButton.titleLabel?.textColor = UIColor.whiteColor()
        favoriteButton.showsTouchWhenHighlighted = true
    }
    
    func toggleFavoriteButton() {
        if favoriteButton.titleLabel?.text == "◎" {
            favoriteButton.setTitle("◉", forState: .Normal)
        } else {
            favoriteButton.setTitle("◎", forState: .Normal)
        }
    }
    
    
    

//        deleteFromFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
//        deleteFromFavoritesButton.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor, constant: -20).active = true
//        deleteFromFavoritesButton.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -20).active = true
//        
//        deleteFromFavoritesButton.titleLabel?.font = wanderSparkFont(16)
//        deleteFromFavoritesButton.titleLabel?.textColor = UIColor.whiteColor()
//        deleteFromFavoritesButton.setTitle("remove from favorites", forState: .Normal)
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
