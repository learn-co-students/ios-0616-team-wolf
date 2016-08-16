//
//  Constants.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/10/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//


import Foundation
import ChameleonFramework

//WanderSpark Font
func wanderSparkFont(size: CGFloat)-> UIFont{

return UIFont(name: "Avenir-Book", size: size)!

}
//Images for matching

 let adventureImage = UIImage(named: "adventure")!
 let beachesImage = UIImage(named: "beaches")!
 let cityImage = UIImage(named: "city")!
 let countryImage = UIImage(named: "country")!
 let fitnessImage = UIImage(named: "fitness")!
 let foodieImage = UIImage(named: "food")!
 let historicImage = UIImage(named: "historic")!
 let luxuryImage = UIImage(named: "luxury")!
 let modernImage = UIImage(named: "modern")!
 let mountainsImage = UIImage(named: "mountains")!
 let nightlifeImage = UIImage(named: "nightlife")!
 let shoppingImage = UIImage(named: "shopping")!
 let outdoorsImage = UIImage(named: "outdoors")!
 let sightseeingImage = UIImage(named: "sightseeing")!

let carousel1 = UIImage(named: "Carousel1")!
let carousel2 = UIImage(named: "Carousel2")!
let carousel3 = UIImage(named: "Carousel3")!
let carousel4 = UIImage(named: "Carousel4")!
let carousel5 = UIImage(named: "china")!
let backgroundButton = UIImage(named: "rectangleBackground-1")!
let wanderSparkIcon =  UIImage(named: "wanderSparkIcon")!
let wanderSparkIconBW =  UIImage(named: "WanderSparkIconBW")!
let china =  UIImage(named: "china")!
let india =  UIImage(named: "india")!
let japan =  UIImage(named: "japan")!
let egypt =  UIImage(named: "egypt")!
let brazil =  UIImage(named: "brazil")!


// Colors

let seafoam = UIColor(red: 112/255, green: 217/255, blue: 169/255, alpha: 1.0)
let teal = UIColor(red: 44/255, green: 157/255, blue: 145/255, alpha: 1.0)
let softWhite = UIColor(red: 252/255, green: 251/255, blue: 242/255, alpha: 1.0)


extension UIImage {
    var circle: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.borderWidth = 4
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

