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

    var sharedUserLocation: UserLocation = UserLocation.sharedInstance

    var orLabel: UILabel = UILabel()
    var sharedLocation: UserLocation? = nil
    var cancelButton: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //This will be the first banner to appear on the screen
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let topBannerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 70))
        topBannerLabel.textAlignment = NSTextAlignment.Center
        topBannerLabel.backgroundColor = UIColor.flatMintColor()
        topBannerLabel.text = "Where are you wandering from?"
        topBannerLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(topBannerLabel)
        
        //This is the button prompting users to use core location
        //userCurrentLocationButton.frame.size.width = 500
        userCurrentLocationButton.backgroundColor = UIColor.flatMintColor()
        userCurrentLocationButton.setTitle("Current Location", forState: UIControlState.Normal)
        userCurrentLocationButton.addTarget(self, action: #selector(enableCoreLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(userCurrentLocationButton)
        
        
        //creation of the departureCityZipcode Label
        let departureCityZipcodeLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
        departureCityZipcodeLabel.center = CGPointMake(160, 284)
        departureCityZipcodeLabel.textAlignment = NSTextAlignment.Center
        departureCityZipcodeLabel.text = "Enter City Zipcode"
        //self.view.addSubview(departureCityZipcodeLabel)
        
        //Creation of the zipcodeTextField
      
        zipcodeTextField.placeholder = "Insert ZipCode here"
        
        
        self.view.addSubview(zipcodeTextField)
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipcodeTextField.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 111).active = true
        zipcodeTextField.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        zipcodeTextField.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        zipcodeTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
//        zipcodeTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: 100).active = true
//        zipcodeTextField.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant: 80).active = true
        zipcodeTextField.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 85).active = true
        
        
        
        //Creation of the submit button
        let submitButton =
            UIButton(frame: CGRectMake(50, 50, 50, 50))
        submitButton.backgroundColor = UIColor.flatMintColor()
        
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.addTarget(self, action: #selector(zipcodeSubmitButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(submitButton)
        
        //constraints on the userCurrentLocationn Button
        userCurrentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        userCurrentLocationButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        userCurrentLocationButton.topAnchor.constraintEqualToAnchor(self.view.topAnchor,constant: 150).active = true
        userCurrentLocationButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        userCurrentLocationButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        
        self.view.addSubview(orLabel)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 175).active = true
        orLabel.bottomAnchor.constraintEqualToAnchor(self.zipcodeTextField.topAnchor, constant: -10).active = true
        orLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        orLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        orLabel.textColor = UIColor.whiteColor()
        orLabel.text = "OR"
        
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        cancelButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        cancelButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -30).active = true
        cancelButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: 0).active = true
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(self.returnHome), forControlEvents: .TouchUpInside)

        
        //constraints on the submitButton
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        submitButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        submitButton.topAnchor.constraintEqualToAnchor(zipcodeTextField.bottomAnchor, constant: 0).active = true
        submitButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: 0).active = true
        
        self.view.backgroundColor = lightMagentaGradient(view.frame)
    }
    
 
    //this is wired to the enable core location button
    func enableCoreLocation(sender: UIButton!) {
        print("enablecorelocation button tapped")
        sharedUserLocation = UserLocation.sharedInstance
        print(sharedUserLocation.location?.coordinate)
        let destinationVC = MatchingViewController()
        self.presentViewController(destinationVC, animated: true, completion: {
            
        })
    }
    
    
    //function to validate the zipcode
    func zipCodeIsValid(text: String) -> Bool
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
    func zipcodeSubmitButtonTapped() {
        
        //unwrapping the zipcodeTextfield
        if let userZipCode = zipcodeTextField.text
        {
            if zipCodeIsValid(userZipCode) == true {
                let userLocation : Location = Location(userZipCode: userZipCode)
                print("calling googleAPI to get coordinates based on user zipcode")
                GoogleMapsAPIClient.getLocationCoordinatesWithCompletion(userLocation, completion: { (success) in
                    if success {
                        // Location coordinates were successfully retrieved
                        print("coordinates updated by Google: \(self.sharedUserLocation.userZipCodeCoordinates)")
                        
                        var coordinates: (Double, Double)
                        
                        if let coords = userLocation.coordinates {
                            coordinates = coords
                            
                            self.sharedUserLocation.userZipCodeCoordinates = coordinates
                            print("zip coordintes from flights parameter VC: \(self.sharedUserLocation.userZipCodeCoordinates)")
                        }
                        
                        let destinationVC = MatchingViewController()
                        self.presentViewController(destinationVC, animated: true
                            , completion: {
                            print("zip coordintes from flights parameter VC completion block for present MVC: \(self.sharedUserLocation.userZipCodeCoordinates)")
                        })
                    }
                })
            }
            else if zipCodeIsValid(userZipCode) == false{
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
    
    
    func returnHome(){
        self.dismissViewControllerAnimated(true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewControllerWithIdentifier("carouselVC")
//        self.presentViewController(destinationVC, animated: true, completion: nil)
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
