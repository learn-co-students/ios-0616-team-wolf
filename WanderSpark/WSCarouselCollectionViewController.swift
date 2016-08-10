//
//  ViewController.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import FZCarousel


class WSCarouselCollectionViewController: UIViewController {
    
    let store = LocationsDataStore.sharedInstance
    @IBOutlet weak var carouselView: FZCarouselView!
    var dictionaryOfLocationsAndPictures: [[String : UIImage]]?
    var arrayOfStringURL: [String] = [String]()
    var arrayOfImages: [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setConstraints()
        
        // 0. set up main queue for UI stuff 
        let mainOperationQueue = NSOperationQueue.mainQueue()
        
        // 1. call swiping function/cocoapod here
        
        
        
        // 2. while user is going through the questions, load NYTimes data
        let obtainLocationsQueue = NSBlockOperation {
            print("locations block called")
            self.store.getLocationsWithCompletion ({ })
        }
        obtainLocationsQueue.qualityOfService = .Utility //or .UserInitiated
        obtainLocationsQueue.completionBlock = {
            print ("in locations completion block")
            if obtainLocationsQueue.finished {
                print("DONE WITH LOCATION QUEUE")
            }
        }
        
        // 3. after NYTimes data has finished loading, obtain coordinates
        let obtainLocationCoordinatesBlockOperation = NSBlockOperation {
            print("Coordinates block called")
            GooglePlacesAPIClient.getLocationCoordinatesWithCompletion({
            })
        }
        obtainLocationCoordinatesBlockOperation.qualityOfService = .Utility //important to set this, if not this will get called first
        obtainLocationCoordinatesBlockOperation.addDependency(obtainLocationsQueue)
        obtainLocationCoordinatesBlockOperation.completionBlock = {
            print("in coordinates completion block")
            if obtainLocationCoordinatesBlockOperation.finished {
                print("DONE WITH COORDINATES QUEUE")
            }
        }
        
        
        //testing
//        let testBlock = NSBlockOperation {
//            if obtainLocationCoordinatesBlockOperation.finished {
//                print("DONE WITH COORDINATES REALLY")
//            } else {
//                print("Nope, not really done yet")
//            }
//        }
//        testBlock.addDependency(obtainLocationsQueue)
//        testBlock.addDependency(obtainLocationCoordinatesBlockOperation)
//        testBlock.qualityOfService = .Utility
        
        mainOperationQueue.addOperations([obtainLocationsQueue, obtainLocationCoordinatesBlockOperation], waitUntilFinished: false)
        
        
        
        // 4. then match destinations and get flight information
        
        
        
        carouselView.clipsToBounds = true
        
        self.createImagesFromURL()
        self.prepareCarousel()

    }

    func createImagesFromURL(){
        arrayOfStringURL.append("https://www.nytimes.com/images/2016/08/07/travel/07HOURS1/07HOURS1-master1050.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/07/31/travel/31HOURS-PORTLAND4/31HOURS-PORTLAND4-master1050.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/07/24/travel/24HOURS1/24HOURS1-jumbo.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/07/24/travel/24HOURS1/24HOURS1-jumbo.jpg")
        arrayOfStringURL.append("https://static01.nyt.com/images/2016/06/05/travel/05HOURS-CHICAGO1_LISTY/05HOURS-CHICAGO1_LISTY-jumbo.jpg")
        
        
        for urlString in arrayOfStringURL{
            let url = NSURL(string: urlString)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            let imageFromURL = UIImage(data: data!)
            arrayOfImages.append(imageFromURL!)
  
        }
    }
    func prepareCarousel(){

        
        carouselView.imageArray = arrayOfImages
        carouselView.crankInterval = 1.0
        carouselView.beginCarousel()
    
    }
    func setConstraints() {
        self.view.removeConstraints(self.view.constraints)
        self.carouselView.removeConstraints(self.carouselView.constraints)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.carouselView.translatesAutoresizingMaskIntoConstraints = false
        
        self.carouselView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.carouselView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.carouselView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.carouselView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}











//        print("prepare for carousel being called!")
//        for location in store.locations{
//
//            for locationString in location.images{
//                let url = NSURL(string: "http://www.nytimes.com/\(locationString)")
//                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//                let imageFromURL = UIImage(data: data!)
//                var myDictionary:[String : UIImage] = [String : UIImage]()
//
//                myDictionary[location.name] = imageFromURL
//                dictionaryOfLocationsAndPictures?.append(myDictionary)
//
//            }
//        }





