//
//  FavoritesCollectionView.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/22/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import CoreData

class FavoritesCollectionView: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let store = LocationsDataStore.sharedInstance
    let favoritesStore = FavoritesDataStore.sharedInstance
    
    var fullSceenImage = UIImageView()
    var blurImage = UIVisualEffectView()
    var vacationCollectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var favoriteImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesStore.fetchFavoriteLocationsData()

        self.view.backgroundColor = UIColor.blackColor()

        createImagesFromString()
        setConstraints()
        setUpCollectionView()
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
        return favoritesStore.favoriteLocations.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! customVacationCell
        
        let favoriteLocation = favoritesStore.favoriteLocations[indexPath.row]
        
        if let favoriteName = favoriteLocation.name {
            cell.locationLabel.text = favoriteName
        }
        
        if let favoriteSnippet = favoriteLocation.snippet {
            cell.snippetLabel.text = favoriteSnippet
        }
        
        cell.imageView.image = favoriteImages[indexPath.row]
        cell.backgroundLocationImage.image = favoriteImages[indexPath.row]
    
        cell.circleProfileView.hidden = true
        cell.airportLabel.hidden = true
        
        cell.priceButton.hidden = true
        cell.priceButton.enabled = false
        
        cell.favoriteButton.hidden = true
        cell.favoriteButton.enabled = false
        
        cell.deleteFromFavoritesButton.hidden = false
        cell.deleteFromFavoritesButton.enabled = true
        cell.deleteFromFavoritesButton.addTarget(self, action: #selector(FavoritesCollectionView.deleteFromFavorites), forControlEvents: .TouchUpInside)
        
        cell.homeButton.setTitle("home", forState: .Normal)
        cell.homeButton.addTarget(self, action: #selector(VacationCollectionView.returnHome), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    
    func createImagesFromString(){
        for favorite in favoritesStore.favoriteLocations {
            if let imageURLString = favorite.imageURL {
                if let url = NSURL(string: "https://www.nytimes.com/\(favorite.imageURL)") {
                    let data = NSData(contentsOfURL: url)
                    let imageFromURL = UIImage(data: data!)
                    favoriteImages.append(imageFromURL!)
                } else { print("Error: Unable to create NSURL from imageURL for favorite \(favorite.name)") }
            }
        }
    }
    
    /*
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
    */
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    func returnHome(){
        self.store.locations.removeAll()
        self.store.matchedLocations.removeAll()
        self.performSegueWithIdentifier("returnHome", sender: self)
    }

    
    func deleteFromFavorites() {
        let selectedCell = vacationCollectionView.visibleCells()[0] as! customVacationCell
        if let selectedIndex = vacationCollectionView.indexPathForCell(selectedCell) {
            let selectedRow = selectedIndex.row
            let selectedFavorite = favoritesStore.favoriteLocations[selectedRow]
            
            favoritesStore.managedObjectContext.deleteObject(selectedFavorite)
        }
    }
    
}
