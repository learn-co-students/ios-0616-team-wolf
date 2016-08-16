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
    var snippetButton: UIButton!
    var imageIsBlurred: Bool = false
    var blurEffectView: UIVisualEffectView!
    var snippetLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        priceButton = UIButton()
        locationLabel = UILabel()
        snippetButton = UIButton()
        snippetLabel = UILabel()
        
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
        

        self.snippetButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.snippetButton.addTarget(self, action: #selector(self.blurImage), forControlEvents: .TouchUpInside)
        
        contentView.addSubview(imageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(snippetButton)
        
        
        
    }
    
    func blurImage(){
        
        if imageIsBlurred == false{
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    self.blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.contentView.bounds
    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]// for supporting device rotation
    blurEffectView.alpha = 0.5
    self.contentView.addSubview(blurEffectView)
    
    self.snippetLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
    self.snippetLabel.frame = self.contentView.bounds
    snippetLabel.backgroundColor = UIColor.clearColor()
    snippetLabel.text = "The Snippet will go here!"
    snippetLabel.font = UIFont(name: "Helvetica-Nue", size: 20)
            snippetLabel.textAlignment = NSTextAlignment.Center
            snippetLabel.textColor = UIColor.whiteColor()
    self.contentView.addSubview(snippetLabel)
            
            UIView.animateWithDuration(0.8) {
                self.blurEffectView.alpha = 1.0
            }
            
            
            imageIsBlurred = true
        }else{
            blurEffectView.removeFromSuperview()
            snippetLabel.removeFromSuperview()
            imageIsBlurred = false
        }
    contentView.addSubview(snippetButton)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
