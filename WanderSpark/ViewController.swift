//
//  ViewController.swift
//  Example
//
//  Created by Flatiron School on 8/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var locationManager: CLLocationManager = CLLocationManager()
    var zipcodeTextField: UITextField = UITextField()
    var userCurrentLocationButton = UIButton(frame: CGRectMake(200, 500, 200, 200))
    
    let userOrigin = UserOrigin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This will be the first banner to appear on the screen
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let topBannerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 70))
        topBannerLabel.textAlignment = NSTextAlignment.Center
        topBannerLabel.backgroundColor = UIColor.blueColor()
        topBannerLabel.text = "Select Departure Location"
        topBannerLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(topBannerLabel)
        
        //This is the button prompting users to use core location
        //userCurrentLocationButton.frame.size.width = 500
        userCurrentLocationButton.backgroundColor = UIColor.orangeColor()
        userCurrentLocationButton.setTitle("Current Location", forState: UIControlState.Normal)
        userCurrentLocationButton.addTarget(self, action: #selector(enableCoreLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(userCurrentLocationButton)
        
        
        //creation of the departureCityZipcode Label
        let departureCityZipcodeLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
        departureCityZipcodeLabel.center = CGPointMake(160, 284)
        departureCityZipcodeLabel.textAlignment = NSTextAlignment.Center
        departureCityZipcodeLabel.text = "Enter City Zipcode"
        self.view.addSubview(departureCityZipcodeLabel)
        
        //Creation of the zipcodeTextField
        zipcodeTextField = UITextField (frame:CGRectMake(10, 10, 30, 10))
        zipcodeTextField.placeholder = "Insert ZipCode here"
        self.view.addSubview(zipcodeTextField)
        
        //Creation of the submit button
        let submitButton =
            UIButton(frame: CGRectMake(50, 50, 50, 50))
        submitButton.backgroundColor = UIColor.orangeColor()
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.addTarget(self, action: #selector(allowUserToInputCityZipcode), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(submitButton)
        
        //constraints on the userCurrentLocationn Button
        userCurrentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        userCurrentLocationButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        userCurrentLocationButton.topAnchor.constraintEqualToAnchor(self.view.topAnchor,constant: 100).active = true
        userCurrentLocationButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        userCurrentLocationButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        
        //constraints on the departureCityZipcode label
        departureCityZipcodeLabel.translatesAutoresizingMaskIntoConstraints = false
       departureCityZipcodeLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        departureCityZipcodeLabel.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        departureCityZipcodeLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        departureCityZipcodeLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        
        
        //creating a uitextfield
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipcodeTextField.topAnchor.constraintEqualToAnchor(departureCityZipcodeLabel.bottomAnchor, constant: 40).active = true
        zipcodeTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: 50).active = true
        
        zipcodeTextField.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        zipcodeTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        
        //zipcode.placeholder constraints so its in the center 
        
        //constraints on the submitButton
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        submitButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        submitButton.topAnchor.constraintEqualToAnchor(zipcodeTextField.bottomAnchor, constant: 0).active = true
        submitButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: 0).active = true

    }

    func enableCoreLocation(sender: UIButton!) {
        print("Enable core location is being called.")
        userOrigin.configureLocationManager()
        userOrigin.requestUserLocation()
    }
    
    
    //function to validate the zipcode
    func isZipCodeValid(text: String) -> Bool
    {
        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
        return zipCodeTestPredicate.evaluateWithObject(zipcodeTextField.text)
    }
    
    func allowUserToInputCityZipcode(sender: UIButton) {
        
        print("User coordinates: \(userOrigin.userCoordinates)")
        
        if isZipCodeValid(zipcodeTextField.text!) == true
        {
            //call on the GoogleAPIClient to convert the zipcode into latitude and longitude coordinates 
            //therefore easiest way is to call the GoogleAPIClient 
            //userOrigin.userCoordinates = the coordinates that come in as a result of the zipcode
        }
        else
        {
            //create the alert
            let alert = UIAlertController(title: "Invalid Zipcode", message: "Enter Valid Zipcode", preferredStyle: UIAlertControllerStyle.Alert)
            //add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            //show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

