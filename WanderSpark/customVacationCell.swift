//
//  customeVacationCell.swift
//  
//
//  Created by Zain Nadeem on 8/10/16.
//
//

import UIKit

class customVacationCell: UICollectionViewCell, UITextViewDelegate {
    var locationLabel: UILabel!
    var priceButton: UIButton!
    var imageView: UIImageView!
    var blurEffectView: UIVisualEffectView!
    var snippetLabel: UITextView!
    var circleProfileView: UIImageView!
    var backgroundLocationImage: UIImageView!
    var homeButton: UIButton!
    var airportLabel: UILabel!
    var readMoreButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundLocationImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundLocationImage.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        priceButton = UIButton()
        locationLabel = UILabel()
        snippetLabel = UITextView()
        circleProfileView = UIImageView()
        backgroundLocationImage = UIImageView()
        homeButton = UIButton()
        airportLabel = UILabel()
        readMoreButton = UIButton()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]// for supporting device rotation
        blurEffectView.alpha = 1
        
        contentView.addSubview(backgroundLocationImage)
        self.contentView.addSubview(blurEffectView)
        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(circleProfileView)
        contentView.addSubview(snippetLabel)
        contentView.addSubview(homeButton)
        contentView.addSubview(airportLabel)
        contentView.addSubview(readMoreButton)
        
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraintEqualToAnchor(self.circleProfileView.bottomAnchor, constant: 50).active = true
        self.imageView.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
        self.imageView.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        self.imageView.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.35).active = true
        self.imageView.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true

        
        self.circleProfileView.translatesAutoresizingMaskIntoConstraints = false
        self.circleProfileView.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 25).active = true
        self.circleProfileView.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.10).active = true
        self.circleProfileView.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.18).active = true
        self.circleProfileView.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 30).active = true
        
        self.backgroundLocationImage.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundLocationImage.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor).active = true
        self.backgroundLocationImage.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor).active = true
        self.backgroundLocationImage.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor).active = true
        self.backgroundLocationImage.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor).active = true
        self.backgroundLocationImage.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true

        self.snippetLabel.translatesAutoresizingMaskIntoConstraints = false
        self.snippetLabel.topAnchor.constraintEqualToAnchor(self.imageView.bottomAnchor, constant: 10).active = true
        self.snippetLabel.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.8).active = true
        self.snippetLabel.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.25).active = true
        self.snippetLabel.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
        
       
        snippetLabel.backgroundColor = UIColor.clearColor()
        snippetLabel.font = wanderSparkFont(20)
        snippetLabel.textAlignment = NSTextAlignment.Justified
        snippetLabel.textColor = UIColor.whiteColor()
        
        snippetLabel.text = "No Information"
        
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.leadingAnchor.constraintEqualToAnchor(self.circleProfileView.trailingAnchor, constant: 20).active = true
        self.locationLabel.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 40).active = true
        self.locationLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -40).active = true
        
        
        locationLabel.font = UIFont(name: "Avenir-Book" , size: 27)
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Center
        locationLabel.layer.shadowRadius = 10
        locationLabel.layer.shadowOpacity = 1.75
        locationLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        self.locationLabel.adjustsFontSizeToFitWidth = true

        self.priceButton.translatesAutoresizingMaskIntoConstraints = false
        self.priceButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -10).active = true
        self.priceButton.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant:-20).active = true
        
        priceButton.titleLabel?.font = wanderSparkFont(50)
        priceButton.titleLabel?.textColor = UIColor.whiteColor()
        priceButton.titleLabel?.shadowColor = UIColor.whiteColor()
        
        
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.homeButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -10).active = true
        self.homeButton.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 20).active = true
        homeButton.titleLabel?.font = wanderSparkFont(14)
        homeButton.titleLabel?.textColor = UIColor.whiteColor()
       
        
        self.readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        self.readMoreButton.topAnchor.constraintEqualToAnchor(self.snippetLabel.bottomAnchor).active = true
        self.readMoreButton.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
        readMoreButton.titleLabel?.font = wanderSparkFont(14)
        readMoreButton.titleLabel?.textColor = UIColor.blueColor()
        
        
        
        
        
        
        
        self.airportLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportLabel.topAnchor.constraintEqualToAnchor(self.priceButton.bottomAnchor, constant: -20).active = true
        self.airportLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -40).active = true
        airportLabel.font = wanderSparkFont(11)
        airportLabel.textColor = UIColor.whiteColor()
        
   

//        contentView.addSubview(imageView)
//        contentView.addSubview(locationLabel)
//        contentView.addSubview(priceButton)
//        contentView.addSubview(circleProfileView)
//        contentView.addSubview(snippetLabel)
//        contentView.addSubview(homeButton)
//        contentView.addSubview(airportLabel)
    
        snippetLabel.delegate = self
    }
    
  

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
