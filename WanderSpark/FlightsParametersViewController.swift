//
//  FlightsParametersViewController.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/17/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit

class FlightsParametersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this button will allow to use Core location to find the user's starting point
        var useCurrentLocButton = UIButton()
        useCurrentLocButton.backgroundColor = UIColor.blueColor()
        useCurrentLocButton.currentTitleColor = UIColor.whiteColor()
        useCurrentLocButton.setTitle("Use origin Coordinates", forState: UIControlState.Normal)
        
        //this button will allow the user to input their city zipcode for their starting point
        var departureCityZipcode = UIButton()
        departureCityZipcode.backgroundColor = UIColor.blueColor()
        departureCityZipcode.currentTitleColor = UIColor.whiteColor()
        departureCityZipcode.setTitle("Input City Zipcode", forState: UIControlState.Normal)
        
        
        //function for useCurrentLocButton
        
        
        //function for departureCityZipcode
        

        // Do any additional setup after loading the view.
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
