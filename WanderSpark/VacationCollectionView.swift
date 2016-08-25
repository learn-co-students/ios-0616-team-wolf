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

    var vacationLocations: [Location] = [Location]()
    var arrayOfVacationImages: [UIImage] = [UIImage]()
    var arrayOfVacationImagesForThumbnail: [UIImage] = [UIImage]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()

        createImagesFromString()
        
        setUpCollectionView()
        
        vacationLocations = store.matchedLocations
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
        
        let location = store.matchedLocations[indexPath.row]
        
        cell.locationLabel.text = location.name
        
        cell.snippetLabel.text = location.description
        
        cell.imageView.image = arrayOfVacationImages[indexPath.row]
        cell.backgroundLocationImage.image = arrayOfVacationImages[indexPath.row]

        cell.readMoreButton.addTarget(self, action: #selector(self.goToArticle), forControlEvents: .TouchUpInside)
        
        
       
        
        cell.favoriteButton.addTarget(self, action: #selector(VacationCollectionView.addToFavorites), forControlEvents: .TouchUpInside)
        if location.favorite == false {
            cell.favoriteButton.setTitle("◎", forState: .Normal)
        } else {
           cell.favoriteButton.setTitle("◉", forState: .Normal)
        }
        
        cell.homeButton.addTarget(self, action: #selector(VacationCollectionView.returnHome), forControlEvents: .TouchUpInside)

        if let lowestPrice = location.cheapestFlight?.lowestPrice {
            cell.priceButton.setTitle("$\(lowestPrice)", forState: .Normal)
        }
        
        if let airportLocation = location.cheapestFlight?.originIATACode {
            cell.airportLabel.text = "from \(airportLocation)"
        }
        
        if let carrierName = location.cheapestFlight?.carrierName {
            if carrierName == "" {
                cell.carrierLabel.hidden = true
            }
            cell.carrierLabel.text = "via \(carrierName)"
        }
        
        return cell
    }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    

    func createImagesFromString(){

        for location in store.matchedLocations{
            if location.images != []{
            let url = NSURL(string: "https://www.nytimes.com/\(location.images[1])")
            let data = NSData(contentsOfURL: url!) 
            let imageFromURL = UIImage(data: data!)
            arrayOfVacationImages.append(imageFromURL!)
            }
        }
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

  
    func returnHome(){
        self.store.locations.removeAll()
        self.store.matchedLocations.removeAll()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewControllerWithIdentifier("carouselVC")
        self.presentViewController(destinationVC, animated: true, completion: nil)
    }
    
    
    func addToFavorites() {
        let selectedCell = vacationCollectionView.visibleCells()[0] as! customVacationCell
        selectedCell.toggleFavoriteButton()
        
        if let selectedIndex = vacationCollectionView.indexPathForCell(selectedCell) {
            let selectedRow = selectedIndex.row
            let selectedLocation = vacationLocations[selectedRow]
            selectedLocation.toggleFavoriteStatus()
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        for location in vacationLocations {
            
            if location.favorite == true {
                favoritesStore.fetchFavoriteLocationsData()
                let sameSelection = favoritesStore.favoriteLocations.filter { $0.name! == location.name }
                
                if sameSelection.isEmpty {
                    
                    let locationDescription = NSEntityDescription.entityForName("FavoriteLocation", inManagedObjectContext: favoritesStore.managedObjectContext)
                    
                    if let locationDescription = locationDescription {
                        
                        let favoriteLocation = FavoriteLocation(entity: locationDescription, insertIntoManagedObjectContext: favoritesStore.managedObjectContext)
                        
                        favoriteLocation.name = location.name
                        favoriteLocation.snippet = location.description
                        favoriteLocation.favorite = true
                        favoriteLocation.articleURL = location.articleURL
                        
                        let imageURLString = location.images[1]
                        if let imageURL = NSURL(string: "https://www.nytimes.com/\(imageURLString)") {
                            favoriteLocation.image = NSData(contentsOfURL: imageURL)
                        }
                    }
                }
            }
        }
        favoritesStore.saveContext()
    }
  
}



