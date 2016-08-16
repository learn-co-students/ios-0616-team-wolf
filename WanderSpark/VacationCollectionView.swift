//
//  VacationCollectionView.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/10/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//


import UIKit

class VacationCollectionView: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let store = LocationsDataStore.sharedInstance
    var fullSceenImage = UIImageView()
    var blurImage = UIVisualEffectView()
    var vacationCollectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    //dummy
    
    var vacationLocations: [Location] = [Location]()
    var arrayOfVacationImages: [UIImage] = [UIImage]()
    var arrayOfVacationImagesForThumbnail: [UIImage] = [UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        store.getLocationsWithCompletion { 
        }
        createImagesForCircleFromString()
        createImagesFromString()
        setConstraints()
        setUpCollectionView()   
    }
    
    func getPrices(){
        
        print("GET PRICES!!!!!!!!!!!!!")
    }
    
    
    func setConstraints() {
//        self.view.removeConstraints(self.view.constraints)
//        self.fullSceenImage.removeConstraints(self.fullSceenImage.constraints)
//        self.blurImage.removeConstraints(self.blurImage.constraints)
//       
//        
//        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.fullSceenImage.translatesAutoresizingMaskIntoConstraints = false
        self.blurImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(fullSceenImage)
        
        self.fullSceenImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
       // self.fullSceenImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.fullSceenImage.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.fullSceenImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.4).active = true
        self.fullSceenImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        
        self.fullSceenImage.addSubview(blurImage)
        
        self.blurImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.blurImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.blurImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.blurImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
    }
    
    func setUpCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        vacationCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        vacationCollectionView.dataSource = self
        vacationCollectionView.delegate = self
        vacationCollectionView.registerClass(customVacationCell.self, forCellWithReuseIdentifier: "Cell")
        vacationCollectionView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(vacationCollectionView)
        vacationCollectionView.pagingEnabled = true
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewWidth = self.view
            .bounds.size.width
        let collectionViewHeight = self.view
            .bounds.size.height
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.matchedLocations.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! customVacationCell
        
        cell.locationLabel.text = store.matchedLocations[indexPath.row].name
        cell.imageView.image = arrayOfVacationImages[indexPath.row]
                //cell.priceButton.setTitle(store.matchedLocations[indexPath.row].cheapestFlight, forState: .Normal)
        cell.priceButton.addTarget(self, action: #selector(VacationCollectionView.getPrices), forControlEvents: .TouchUpInside)
        cell.snippetLabel.numberOfLines = 0
        cell.snippetLabel.text = store.matchedLocations[indexPath.row].description
         cell.snippetLabel.sizeToFit()
        cell.circleProfileView.image = arrayOfVacationImagesForThumbnail[indexPath.row].circle
        cell.backgroundLocationImage.image = arrayOfVacationImages[indexPath.row].circle
        print("cell for row at index path was just called -- the description is: \(cell.snippetLabel.text!)")
      
        
        return cell
    }
    
    
    func createImagesFromString(){
        // append images from assets

        
        for location in store.matchedLocations{
            if location.images != []{
            let url = NSURL(string: "https://www.nytimes.com/\(location.images[1])")
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            let imageFromURL = UIImage(data: data!)
            arrayOfVacationImages.append(imageFromURL!)
            }
        }
    }
    
    func createImagesForCircleFromString(){
        // append images from assets
        
        
        for location in store.matchedLocations{
            if location.images != []{
                let url = NSURL(string: "https://www.nytimes.com/\(location.images[0])")
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                let imageFromURL = UIImage(data: data!)
                arrayOfVacationImagesForThumbnail.append(imageFromURL!)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


