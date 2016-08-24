//
//  VacationCollectionView.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/10/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//


import UIKit
import CoreData

class VacationCollectionView: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextViewDelegate {
    
    let store = LocationsDataStore.sharedInstance
    let favoritesStore = FavoritesDataStore.sharedInstance
    
    var fullSceenImage = UIImageView()
    var blurImage = UIVisualEffectView()
    var vacationCollectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var webView: UIWebView = UIWebView()

    var vacationLocations: [Location] = [Location]()
    var arrayOfVacationImages: [UIImage] = [UIImage]()
    var arrayOfVacationImagesForThumbnail: [UIImage] = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()

        createImagesForCircleFromString()
        createImagesFromString()
        setConstraints()
        setUpCollectionView()
        

    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    func goToArticle(){
        print(self.vacationCollectionView.visibleCells())
        let currentCell = self.vacationCollectionView.visibleCells()[0]
        let currentIndexPath = self.vacationCollectionView.indexPathForCell(currentCell)
        let url = NSURL (string: store.matchedLocations[(currentIndexPath?.row)!].articleURL)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    
    func setConstraints() {
        self.fullSceenImage.translatesAutoresizingMaskIntoConstraints = false
        self.blurImage.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(fullSceenImage)
        
        self.fullSceenImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
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
        
        cell.snippetLabel.text = store.matchedLocations[indexPath.row].description
        cell.snippetLabel.allowsEditingTextAttributes = false
        cell.snippetLabel.backgroundColor = UIColor.clearColor()
        cell.snippetLabel.font = wanderSparkFont(20)
        cell.snippetLabel.delegate = self
        cell.snippetLabel.userInteractionEnabled = true
        cell.snippetLabel.scrollEnabled = false
        cell.snippetLabel.selectable = true
        
        cell.imageView.image = arrayOfVacationImages[indexPath.row]
        cell.circleProfileView.image = arrayOfVacationImagesForThumbnail[indexPath.row].circle
        cell.backgroundLocationImage.image = arrayOfVacationImages[indexPath.row]
        
        cell.airportLabel.hidden = false
        if let airportLocation = store.matchedLocations[indexPath.row].cheapestFlight?.originIATACode{
            cell.airportLabel.text = "from \(airportLocation)"
        }

        cell.readMoreButton.setTitle("Read More", forState: .Normal)
        cell.readMoreButton.addTarget(self, action: #selector(self.goToArticle), forControlEvents: .TouchUpInside)
        
        cell.priceButton.hidden = false
        cell.priceButton.enabled = true
        if let lowestPrice = store.matchedLocations[indexPath.row].cheapestFlight?.lowestPrice{
            cell.priceButton.setTitle("$\(lowestPrice)", forState: .Normal)
        }
        //cell.priceButton.addTarget(self, action: #selector(VacationCollectionView.getPrices), forControlEvents: .TouchUpInside)
        
        cell.favoriteButton.hidden = false
        cell.favoriteButton.enabled = true
        cell.favoriteButton.addTarget(self, action: #selector(VacationCollectionView.addToFavorites), forControlEvents: .TouchUpInside)
        
        cell.deleteFromFavoritesButton.hidden = true
        cell.deleteFromFavoritesButton.enabled = false
        
        cell.homeButton.setTitle("home", forState: .Normal)
        cell.homeButton.addTarget(self, action: #selector(VacationCollectionView.returnHome), forControlEvents: .TouchUpInside)
        
        return cell
    }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    

    func createImagesFromString(){

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

  
    func returnHome(){
        self.store.locations.removeAll()
        self.store.matchedLocations.removeAll()
        self.performSegueWithIdentifier("returnHome", sender: self)
    }
    
    
    func addToFavorites() {
        let selectedCell = vacationCollectionView.visibleCells()[0] as! customVacationCell
        if let selectedIndex = vacationCollectionView.indexPathForCell(selectedCell) {
            let selectedRow = selectedIndex.row
            let selectedLocation = store.matchedLocations[selectedRow]
            
            favoritesStore.fetchFavoriteLocationsData()
            let sameSelection = favoritesStore.favoriteLocations.filter { $0.name! == selectedLocation.name }
            
            if sameSelection.isEmpty {
                
                let locationDescription = NSEntityDescription.entityForName("FavoriteLocation", inManagedObjectContext: favoritesStore.managedObjectContext)
                
                if let locationDescription = locationDescription {
                    
                    let favoriteLocation = FavoriteLocation(entity: locationDescription, insertIntoManagedObjectContext: favoritesStore.managedObjectContext)
                    
                    favoriteLocation.name = selectedLocation.name
                    favoriteLocation.imageURL = selectedLocation.images[1]
                    favoriteLocation.snippet = selectedLocation.description
                    favoriteLocation.matchCount = selectedLocation.matchCount
                    favoriteLocation.articleURL = selectedLocation.articleURL
                }
                favoritesStore.saveContext()
            }
        }
    }
    
   
}



