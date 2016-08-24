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
    var favoritesCollectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var favoriteImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesStore.fetchFavoriteLocationsData()

        self.view.backgroundColor = UIColor.blackColor()

        createImagesFromString()
        setUpCollectionView()
    }
    

    func setUpCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        favoritesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        favoritesCollectionView.registerClass(customVacationCell.self, forCellWithReuseIdentifier: "Cell")
        favoritesCollectionView.backgroundColor = UIColor.blackColor()
        favoritesCollectionView.pagingEnabled = true
        
        self.view.addSubview(favoritesCollectionView)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewWidth = self.view
            .bounds.size.width
        let collectionViewHeight = self.view
            .bounds.size.height
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoritesStore.favoriteLocations.isEmpty {
            return 1
        } else {
            return favoritesStore.favoriteLocations.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! customVacationCell
        
        cell.airportLabel.hidden = true
        
        cell.priceButton.hidden = true
        cell.priceButton.enabled = false
        
        cell.favoriteButton.hidden = true
        cell.favoriteButton.enabled = false
        
        cell.homeButton.addTarget(self, action: #selector(VacationCollectionView.returnHome), forControlEvents: .TouchUpInside)
        
        //cell.readMoreButton.addTarget(self, action: #selector(VacationCollectionView.goToArticle), forControlEvents: .TouchUpInside)
        
        if favoritesStore.favoriteLocations.isEmpty {
            
            cell.deleteFromFavoritesButton.hidden = true
            cell.deleteFromFavoritesButton.enabled = false
            
            cell.snippetLabel.text = "You have no destinations stored in favorites."
            
            return cell
            
        } else {
            
            let favoriteLocation = favoritesStore.favoriteLocations[indexPath.row]
            
            if let favoriteName = favoriteLocation.name {
                cell.locationLabel.text = favoriteName
            }
            
            if let favoriteSnippet = favoriteLocation.snippet {
                cell.snippetLabel.text = favoriteSnippet
            }
            
            cell.imageView.image = favoriteImages[indexPath.row]
            cell.backgroundLocationImage.image = favoriteImages[indexPath.row]
            
            cell.deleteFromFavoritesButton.hidden = false
            cell.deleteFromFavoritesButton.enabled = true
            cell.deleteFromFavoritesButton.addTarget(self, action: #selector(FavoritesCollectionView.deleteFromFavorites), forControlEvents: .TouchUpInside)
            
            return cell
        }
    }
    
    
    func createImagesFromString(){
        for favorite in favoritesStore.favoriteLocations {
            if let imageData = favorite.image {
                if let image = UIImage(data: imageData) {
                    favoriteImages.append(image)
                }
            } else { print("Error: Unable to create image from NSData for favorite \(favorite.name)") }
            
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    func returnHome(){
        self.store.locations.removeAll()
        self.store.matchedLocations.removeAll()
        self.dismissViewControllerAnimated(true) {
        }
    }

    
    func deleteFromFavorites() {
        let selectedCell = favoritesCollectionView.visibleCells()[0] as! customVacationCell
        
        if favoritesStore.favoriteLocations.count == 1 {
            var numberOfCells = self.collectionView(favoritesCollectionView, numberOfItemsInSection: 0)
            numberOfCells += 1
        }
        
        if let selectedIndex = favoritesCollectionView.indexPathForCell(selectedCell) {
            let selectedRow = selectedIndex.row
            let nextIndex = NSIndexPath(forRow: selectedRow + 1, inSection: 0)
            
            let selectedFavorite = favoritesStore.favoriteLocations[selectedRow]
            
            favoritesStore.managedObjectContext.deleteObject(selectedFavorite)
            favoritesStore.saveContext()
            favoritesStore.fetchFavoriteLocationsData()
            favoritesCollectionView.reloadData()
            
            favoritesCollectionView.scrollToItemAtIndexPath(nextIndex, atScrollPosition: .Right, animated: true)    
        }
    }
    
}
