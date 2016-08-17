//
//  FlightsParametersViewController.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/17/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit

class UserAlternateLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    //To do list::::
    //Add the two buttons
    //Add the textField for user departure city zipcode 
    //create two functions for each of the buttons
    //link each of the functions to their appropriate functions that they need to do 
        
        let useCurrentLocButton = UIButton(frame: CGRectMake(50, 50, 50, 50))
        useCurrentLocButton.backgroundColor = UIColor.blueColor()
        useCurrentLocButton.setTitle("Use user origin", forState: UIControlState.Normal)
        //useCurrentLocButton.frame = CGRectMake(50, 50, 50, 50)
        useCurrentLocButton.addTarget(self, action: #selector(implementCoreLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(useCurrentLocButton)
        
        //this button will allow the user to input their city zipcode for their starting point
        let departureCityZipcode = UIButton(frame: CGRectMake(50, 50, 50, 50))
        departureCityZipcode.backgroundColor = UIColor.blueColor()
        departureCityZipcode.setTitle("Input user city zipcode", forState: UIControlState.Normal)
        //departureCityZipcode.frame = CGRectMake(50, 50, 50, 50)
        departureCityZipcode.addTarget(self, action: #selector(allowUserToInputCityZipcode), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(departureCityZipcode)
        
        //constraints on the useCurrentLocButton buttons
        useCurrentLocButton.translatesAutoresizingMaskIntoConstraints = false
        useCurrentLocButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        useCurrentLocButton.topAnchor.constraintEqualToAnchor(self.view.topAnchor,constant: 100).active = true
        useCurrentLocButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        useCurrentLocButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        
        //constraints on the departureCityZipcode button
        departureCityZipcode.translatesAutoresizingMaskIntoConstraints = false
        departureCityZipcode.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        departureCityZipcode.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        departureCityZipcode.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        departureCityZipcode.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true
        
        
        //creating a uitextfield
        //constrains on the uitextfield
        let zipcodeTextField: UITextField = UITextField (frame:CGRectMake(10, 10, 30, 10));
        self.view.addSubview(zipcodeTextField)
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipcodeTextField.topAnchor.constraintEqualToAnchor(departureCityZipcode.bottomAnchor, constant: 40).active = true
        zipcodeTextField.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        zipcodeTextField.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.10).active = true
        zipcodeTextField.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.50).active = true

        
    }
    //Add constraints to the buttons so that they are in the center of the view controller
    //Now connect the userOrigin class so that it connects over
    
    
    //add the functions
    func implementCoreLocation(sender:UIButton)
    {
        
    }
    
    func allowUserToInputCityZipcode (sender: UIButton)
    {
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
