//
//  FirstOnBoardingViewController.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/22/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import ChameleonFramework

class FirstOnBoardingViewController: UIViewController {

    let doneButton: UIButton = UIButton(type: .System)
    let containerView: UIView = UIView()
    let pageView: UIPageViewController = UIPageViewController()
    let iphoneImage: UIImageView = UIImageView()
    let wandersparkTitleLabel: UILabel = UILabel()
    let wandersparkTagline: UILabel = UILabel()
    let wandersparkInstructionText: UITextView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.removeConstraints(self.view.constraints)
        self.view.translatesAutoresizingMaskIntoConstraints = false
       
        setUpDoneButton()
        setUpPageView()
        setUpImageView()
        setUpTitleLabel()
        setUpTaglineLabel()
        setUpInstructionText()
        print("On Boarding View Did Load")
        self.view.backgroundColor = lightMagentaGradientReversed(view.frame)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTitleLabel(){
        self.view.addSubview(wandersparkTitleLabel)
        self.wandersparkTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.wandersparkTitleLabel.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 10).active = true
        self.wandersparkTitleLabel.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 30).active = true
        self.wandersparkTitleLabel.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.wandersparkTitleLabel.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.1).active = true
        
        self.wandersparkTitleLabel.text = "Welcome to WanderSpark!"
        self.wandersparkTitleLabel.font = wanderSparkFont(30)
        self.wandersparkTitleLabel.textColor = UIColor.whiteColor()
   
    }
    
    func setUpTaglineLabel(){
        self.view.addSubview(wandersparkTagline)
        self.wandersparkTagline.translatesAutoresizingMaskIntoConstraints = false
        self.wandersparkTagline.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.wandersparkTagline.topAnchor.constraintEqualToAnchor(self.wandersparkTitleLabel.bottomAnchor, constant: 7).active = true
        
  
        self.wandersparkTagline.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.1).active = true
        
        self.wandersparkTagline.text = "Your Destination Match-Maker!"
        self.wandersparkTagline.font = wanderSparkFont(20)
        self.wandersparkTagline.textColor = UIColor.whiteColor()
        
    }

    
    func setUpImageView(){
        self.view.addSubview(iphoneImage)
        self.iphoneImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.iphoneImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.iphoneImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.iphoneImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.4).active = true
        self.iphoneImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.45).active = true
       
        self.iphoneImage.image = UIImage(named: "IphonePurple")
    
    }
    

    func setUpDoneButton(){
 
        self.view.addSubview(doneButton)
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.doneButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.doneButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -20).active = true


        self.doneButton.setTitle("Start Wandering", forState: .Normal)
        self.doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.doneButton.addTarget(self, action: #selector(self.doneButtonTapped), forControlEvents: .TouchUpInside)
    
    }
    

    func setUpPageView(){
        pageView.view.backgroundColor = UIColor.orangeColor()
        self.containerView.addSubview(pageView.view)
        self.pageView.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.pageView.view.centerXAnchor.constraintEqualToAnchor(self.containerView.centerXAnchor).active = true
        self.pageView.view.centerYAnchor.constraintEqualToAnchor(self.containerView.centerYAnchor).active = true
        self.pageView.view.widthAnchor.constraintEqualToAnchor(self.containerView.widthAnchor, multiplier: 0.7).active = true
        self.pageView.view.heightAnchor.constraintEqualToAnchor(self.containerView.heightAnchor, multiplier: 0.7).active = true
       
    }
    func setUpInstructionText(){
        self.view.addSubview(wandersparkInstructionText)
        self.wandersparkInstructionText.translatesAutoresizingMaskIntoConstraints = false
        self.wandersparkInstructionText.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.wandersparkInstructionText.topAnchor.constraintEqualToAnchor(self.iphoneImage.bottomAnchor, constant: 15).active = true
         self.wandersparkInstructionText.bottomAnchor.constraintEqualToAnchor(self.doneButton.topAnchor, constant: 10).active = true
//        self.wandersparkInstructionText.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.3).active = true
        self.wandersparkInstructionText.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.8).active = true
        
        
    
        self.wandersparkInstructionText.text = "It's easy, swipe right for the vacation attractions you love and left for the ones you would like to pass on!"
        self.wandersparkInstructionText.font = wanderSparkFont(15)
        self.wandersparkInstructionText.textColor = UIColor.whiteColor()
        wandersparkInstructionText.backgroundColor = UIColor.clearColor()
        wandersparkInstructionText.font = wanderSparkFont(20)
        wandersparkInstructionText.textAlignment = NSTextAlignment.Left
        wandersparkInstructionText.sizeToFit()
        wandersparkInstructionText.userInteractionEnabled = false
        
  
        
    }


    func doneButtonTapped(){
        //set the default
        print("Done Button Tapped")
        groupDefaults().setBool(true, forKey: onboardingKey)
        //now load the main storyboard
        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
        ad.launchStoryboard(Storyboard.Main)
    
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




