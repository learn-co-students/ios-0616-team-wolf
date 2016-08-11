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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        store.getLocationsWithCompletion { 
        }
 
        setConstraints()
        setUpCollectionView()
        
    }
    
    func getPrices(){
        
        print("GET PRICES!!!!!!!!!!!!!")
    }
    
    
    func setConstraints() {
        self.view.removeConstraints(self.view.constraints)
        self.fullSceenImage.removeConstraints(self.fullSceenImage.constraints)
        self.blurImage.removeConstraints(self.blurImage.constraints)
       
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.fullSceenImage.translatesAutoresizingMaskIntoConstraints = false
        self.blurImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(fullSceenImage)
        
        self.fullSceenImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.fullSceenImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.fullSceenImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.fullSceenImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        
        self.fullSceenImage.addSubview(blurImage)
        
        self.blurImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.blurImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.blurImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.blurImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true

        
        //        self.vacationsCollectionView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        //        self.vacationsCollectionView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        //        self.vacationsCollectionView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.5).active = true
        //        self.vacationsCollectionView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5).active = true
        
    }
    
    func setUpCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(self.view.width, height: 120)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        
        vacationCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        vacationCollectionView.dataSource = self
        vacationCollectionView.delegate = self
        vacationCollectionView.registerClass(customVacationCell.self, forCellWithReuseIdentifier: "Cell")
        vacationCollectionView.backgroundColor = UIColor.whiteColor()
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
        return 14
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! customVacationCell
        cell.locationLabel.text = "China"
        cell.imageView.image = UIImage(named: "China")
        cell.priceButton.setTitle("*from: $1999", forState: .Normal)
        cell.priceButton.addTarget(self, action: #selector(VacationCollectionView.getPrices), forControlEvents: .TouchUpInside)
      
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
