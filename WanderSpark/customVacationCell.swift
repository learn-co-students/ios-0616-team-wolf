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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
       imageView.clipsToBounds = true
        priceButton = UIButton()
        locationLabel = UILabel()
        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -60).active = true
        self.locationLabel.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -60).active = true
        
        locationLabel.font = UIFont(name: "Helvetica" , size: 45)
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Center
        locationLabel.layer.shadowRadius = 10
        locationLabel.layer.shadowOpacity = 1.75
        locationLabel.layer.shadowColor = UIColor.blackColor().CGColor
        

        
        self.priceButton.translatesAutoresizingMaskIntoConstraints = false
        self.priceButton.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -30).active = true
        self.priceButton.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -60).active = true
        

        
        
        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
