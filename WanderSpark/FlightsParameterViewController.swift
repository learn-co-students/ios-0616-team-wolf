//
//  FlightsParameterViewController.swift
//
//
//  Created by Flatiron School on 8/22/16.
//
//

import UIKit
import CoreLocation

class FlightsParameterViewController: UIViewController {
    
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var locationManager: CLLocationManager = CLLocationManager()
    var zipcodeTextField: UITextField = UITextField()
    var userCurrentLocationButton = UIButton(frame: CGRectMake(200, 500, 200, 200))
    var sharedLocation: UserLocation? = nil
    
    let getUserLocationCoordinates = UserLocation.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //        view.addGestureRecognizer(tap)
    }
    
    //    func dismissKeyboard() {
    //        //Causes the view (or one of its embedded text fields) to resign the first responder status.
    //        view.endEditing(true)
    //    }
    
    //this is wired to the enable core location button
    func enableCoreLocation(sender: UIButton!) {
        print("enablecorelocation button tapped")
        sharedLocation = UserLocation.sharedInstance
        //sharedLocation?.location?.coordinate
        print(sharedLocation?.location?.coordinate)
        let destinationVC = MatchingViewController()
        self.presentViewController(destinationVC, animated: true, completion: {
            
        })
    }
    
    
    //function to validate the zipcode
    func isZipCodeValid(text: String) -> Bool
    {
        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
        return zipCodeTestPredicate.evaluateWithObject(zipcodeTextField.text)
    }
    
    //function to show animation upon invalid input of zipcode in the UITextField
    func shakeTextField(textField: UITextField)
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 10, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 10, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }
    
    //function to check whether zipcode is correct or not and based on that provide appropriate action
    //this is wired to the submit button
    func allowUserToInputCityZipcode() {
        
        //unwrapping the zipcodeTextfield
        if let userZipCode = zipcodeTextField.text
        {
            if isZipCodeValid(userZipCode) == true {
                let userLocation : Location = Location(userZipCode: userZipCode)
                GoogleMapsAPIClient.getLocationCoordinatesWithCompletion(userLocation, completion: { (getZipCode) in
                    print("calling googleAPI to get coordinates based on user zipcode")
                    print("\(self.getUserLocationCoordinates.userZipCodeCoordinates)")
                    
                    self.getUserLocationCoordinates.userZipCodeCoordinates = userLocation.coordinates
                    
                    let destinationVC = MatchingViewController()
                    self.presentViewController(destinationVC, animated: true
                        , completion: {
                       
                    })
                })
            }
            else if isZipCodeValid(userZipCode) == false{
                shakeTextField(zipcodeTextField)
            }
            //self.performSegueWithIdentifier("GoingFromFlightsToMatchMaker", sender: self)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showMatchMaker" {
            let destinationVC = MatchingViewController()
            self.presentViewController(destinationVC, animated: true, completion: {
            })
            
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
