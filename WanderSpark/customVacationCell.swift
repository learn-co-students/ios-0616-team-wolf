//
//  customeVacationCell.swift
//  
//
//  Created by Zain Nadeem on 8/10/16.
//
//

import UIKit

class customVacationCell: UICollectionViewCell {
    var locationLabel: UILabel!
    var priceButton: UIButton!
    var imageView: UIImageView!
    //var snippetButton: UIButton!
    //var imageIsBlurred: Bool = false
    var blurEffectView: UIVisualEffectView!
    var snippetLabel: UITextView!
    var circleProfileView: UIImageView!
    var backgroundLocationImage: UIImageView!
    var homeButton: UIButton!
    var airportLabel: UILabel!
    
    var favoriteButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundLocationImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        backgroundLocationImage.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        priceButton = UIButton()
        locationLabel = UILabel()
        //snippetButton = UIButton()
        snippetLabel = UITextView()
        circleProfileView = UIImageView()
        backgroundLocationImage = UIImageView()
        homeButton = UIButton()
        airportLabel = UILabel()
        
        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(circleProfileView)
        contentView.addSubview(backgroundLocationImage)
        contentView.addSubview(snippetLabel)
        contentView.addSubview(homeButton)
        contentView.addSubview(airportLabel)
        configureFavoriteButton()
        
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
        self.snippetLabel.heightAnchor.constraintEqualToAnchor(self.contentView.heightAnchor, multiplier: 0.2).active = true
        self.snippetLabel.centerXAnchor.constraintEqualToAnchor(self.contentView.centerXAnchor).active = true
        //self.snippetLabel.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        //contentView.bringSubviewToFront(snippetLabel)
        
        
        
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
        
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.homeButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -10).active = true
        self.homeButton.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 20).active = true
       
        self.airportLabel.translatesAutoresizingMaskIntoConstraints = false
        self.airportLabel.topAnchor.constraintEqualToAnchor(self.priceButton.bottomAnchor, constant: -20).active = true
        self.airportLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -40).active = true

//        self.snippetButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
//        self.snippetButton.addTarget(self, action: #selector(self.blurImage), forControlEvents: .TouchUpInside)
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]// for supporting device rotation
        blurEffectView.alpha = 1
        self.contentView.addSubview(blurEffectView)
        
        snippetLabel.backgroundColor = UIColor.clearColor()
        snippetLabel.font = wanderSparkFont(20)
        snippetLabel.textAlignment = NSTextAlignment.Justified
        snippetLabel.textColor = UIColor.whiteColor()
        snippetLabel.text = "No Information"
        
        priceButton.titleLabel?.font = wanderSparkFont(50)
        priceButton.titleLabel?.textColor = UIColor.whiteColor()
        priceButton.titleLabel?.shadowColor = UIColor.whiteColor()
        
        homeButton.titleLabel?.font = wanderSparkFont(14)
        homeButton.titleLabel?.textColor = UIColor.whiteColor()
        
        airportLabel.font = wanderSparkFont(11)
        airportLabel.textColor = UIColor.whiteColor()
        
        
//        priceButton.titleLabel?.sizeToFit()
//        priceButton.layer.borderWidth = 1
//        priceButton.layer.borderColor = UIColor.whiteColor().CGColor
//        priceButton.backgroundColor = UIColor.clearColor()
        

        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(circleProfileView)
        contentView.addSubview(snippetLabel)
        contentView.addSubview(homeButton)
        contentView.addSubview(airportLabel)
        contentView.addSubview(favoriteButton)
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
        //favoriteButton.setTitle("❤︎", forState: .Normal)
    }
    
    
//    func blurImage(){
//        
//        if imageIsBlurred == false{
//    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//    self.blurEffectView = UIVisualEffectView(effect: blurEffect)
//    blurEffectView.frame = self.contentView.bounds
//    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]// for supporting device rotation
//    blurEffectView.alpha = 0.5
//    self.contentView.addSubview(blurEffectView)
//    
//    self.snippetLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height))
//    self.snippetLabel.frame = self.contentView.bounds
//  
//            UIView.animateWithDuration(0.8) {
//                self.blurEffectView.alpha = 1.0
//                self.blurEffectView.addSubview(self.snippetLabel)
//            }
//            imageIsBlurred = true
//        }else{
//            blurEffectView.removeFromSuperview()
//            snippetLabel.removeFromSuperview()
//            imageIsBlurred = false
//        }
//    contentView.addSubview(snippetButton)
//       // self.contentView.addSubview(snippetLabel)
//    print("Snippet was just added! for the second time")
//        
//    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
