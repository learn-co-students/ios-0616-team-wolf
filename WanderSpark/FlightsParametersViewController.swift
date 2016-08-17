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
        let useCurrentLocButton = UIButton(type: UIButtonType.System)
        useCurrentLocButton.backgroundColor = UIColor.blueColor()
        useCurrentLocButton.setTitle("Use user origin", forState: UIControlState.Normal)
        useCurrentLocButton.frame = CGRectMake(100, 100, 100, 50)
        useCurrentLocButton.addTarget(self, action: #selector(implementCoreLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(useCurrentLocButton)
        
        //this button will allow the user to input their city zipcode for their starting point
       let departureCityZipcode = UIButton(type: UIButtonType.System)
        departureCityZipcode.backgroundColor = UIColor.blueColor()
        departureCityZipcode.setTitle("Input user city zipcode", forState: UIControlState.Normal)
        departureCityZipcode.frame = CGRectMake(100, 100, 100, 50)
        departureCityZipcode.addTarget(self, action: #selector(allowUserToInputCityZipcode), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(departureCityZipcode)
        
    }

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
