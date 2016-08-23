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
    var backgroundLocationImage: UIImageView!
    var imageView: UIImageView!
    var circleProfileView = UIImageView()
    
    var snippetLabel = UITextView()
    var locationLabel = UILabel()
    var airportLabel = UILabel()
    
    var homeButton = UIButton()
    var priceButton = UIButton()
    var readMoreButton = UIButton()
    var favoriteButton = UIButton()
    var deleteFromFavoritesButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundLocationImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        contentView.addSubview(circleProfileView)
        self.circleProfileView.translatesAutoresizingMaskIntoConstraints = false
        self.circleProfileView.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 25).active = true
        self.circleProfileView.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.10).active = true
        self.circleProfileView.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.18).active = true
        self.circleProfileView.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 30).active = true
        
        configureBackgroundImage()
        configureBlurEffectView()
        configureImageView()
        configureLocationLabel()
        configureSnippetLabel()
        configureReadMoreButton()
        configureHomeButton()
        configurePriceButton()
        configureFavoriteButton()
        configureDeleteFromFavoritesButton()
        configureAirportLabel()

        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(circleProfileView)
        contentView.addSubview(snippetLabel)
        contentView.addSubview(homeButton)
        contentView.addSubview(airportLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(deleteFromFavoritesButton)
    }
    
    
    func configureAirportLabel() {
        contentView.addSubview(airportLabel)
        
        airportLabel.font = wanderSparkFont(11)
        airportLabel.textColor = UIColor.whiteColor()
        
        self.airportLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportLabel.topAnchor.constraintEqualToAnchor(self.priceButton.bottomAnchor, constant: -20).active = true
        self.airportLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -40).active = true
    }
    
    
    func configureLocationLabel() {
        contentView.addSubview(locationLabel)
        
        locationLabel.font = wanderSparkFont(27)
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Center
        locationLabel.adjustsFontSizeToFitWidth = true
        
        //locationLabel.layer.shadowRadius = 10
        //locationLabel.layer.shadowOpacity = 1.75
        //locationLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.leadingAnchor.constraintEqualToAnchor(self.circleProfileView.trailingAnchor, constant: 20).active = true
        self.locationLabel.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 40).active = true
        self.locationLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -40).active = true
    }
    
    
    func configureSnippetLabel() {
        contentView.addSubview(snippetLabel)
        
        self.snippetLabel.translatesAutoresizingMaskIntoConstraints = false
        self.snippetLabel.topAnchor.constraintEqualToAnchor(self.imageView.bottomAnchor, constant: 10).active = true
        self.snippetLabel.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.8).active = true
        self.snippetLabel.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.25).active = true
        self.snippetLabel.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
        
        snippetLabel.delegate = self
        snippetLabel.backgroundColor = UIColor.clearColor()
        snippetLabel.font = wanderSparkFont(20)
        snippetLabel.textAlignment = NSTextAlignment.Justified
        snippetLabel.textColor = UIColor.whiteColor()
        snippetLabel.text = "No Information"
    }
    
    
    func configureBackgroundImage() {
        contentView.addSubview(backgroundLocationImage)
        
        backgroundLocationImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.backgroundLocationImage.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundLocationImage.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor).active = true
        self.backgroundLocationImage.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
        self.backgroundLocationImage.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        self.backgroundLocationImage.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor).active = true
    }
    
    
    func configureBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]// for supporting device rotation
        blurEffectView.alpha = 1
        
        contentView.addSubview(blurEffectView)
    }
    
    
    func configureImageView() {
        contentView.addSubview(imageView)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraintEqualToAnchor(self.circleProfileView.bottomAnchor, constant: 50).active = true
        self.imageView.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
        self.imageView.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        self.imageView.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.35).active = true
        //self.imageView.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
    }
    
    
    func configureReadMoreButton() {
        contentView.addSubview(readMoreButton)
        
        readMoreButton.titleLabel?.font = wanderSparkFont(14)
        readMoreButton.titleLabel?.textColor = UIColor.blueColor()
        
        self.readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        self.readMoreButton.topAnchor.constraintEqualToAnchor(self.snippetLabel.bottomAnchor).active = true
        self.readMoreButton.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
    }
    
    
    func configureHomeButton() {
        contentView.addSubview(homeButton)
        
        homeButton.titleLabel?.font = wanderSparkFont(14)
        homeButton.titleLabel?.textColor = UIColor.whiteColor()
        
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.homeButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -10).active = true
        self.homeButton.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 20).active = true
    }
    
    
    func configurePriceButton() {
        contentView.addSubview(priceButton)
        
        priceButton.titleLabel?.font = wanderSparkFont(50)
        priceButton.titleLabel?.textColor = UIColor.whiteColor()
        priceButton.titleLabel?.shadowColor = UIColor.whiteColor()
        
        self.priceButton.translatesAutoresizingMaskIntoConstraints = false
        self.priceButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -10).active = true
        self.priceButton.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant:-20).active = true
    }
    
  
    func configureFavoriteButton() {
        contentView.addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.bottomAnchor.constraintEqualToAnchor(homeButton.bottomAnchor).active = true
        favoriteButton.leadingAnchor.constraintEqualToAnchor(homeButton.trailingAnchor, constant: 10).active = true
        favoriteButton.widthAnchor.constraintEqualToConstant(30).active = true
        favoriteButton.heightAnchor.constraintEqualToConstant(30).active = true
        
        favoriteButton.titleLabel?.font = wanderSparkFont(30)
        favoriteButton.titleLabel?.textColor = UIColor.whiteColor()
        favoriteButton.setTitle("❤︎", forState: .Normal)
    }
    
    
    func configureDeleteFromFavoritesButton() {
        contentView.addSubview(deleteFromFavoritesButton)
        
        deleteFromFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        deleteFromFavoritesButton.bottomAnchor.constraintEqualToAnchor(homeButton.bottomAnchor).active = true
        deleteFromFavoritesButton.leadingAnchor.constraintEqualToAnchor(homeButton.trailingAnchor, constant: 10).active = true
        deleteFromFavoritesButton.widthAnchor.constraintEqualToConstant(30).active = true
        deleteFromFavoritesButton.heightAnchor.constraintEqualToConstant(30).active = true
        
        deleteFromFavoritesButton.titleLabel?.font = wanderSparkFont(30)
        deleteFromFavoritesButton.titleLabel?.textColor = UIColor.whiteColor()
        deleteFromFavoritesButton.setTitle("Delete", forState: .Normal)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
