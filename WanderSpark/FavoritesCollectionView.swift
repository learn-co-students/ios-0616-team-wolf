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
        }
        return favoritesStore.favoriteLocations.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! customVacationCell
        
        cell.airportLabel.hidden = true
        cell.carrierLabel.hidden = true
        
        cell.priceButton.hidden = true
        cell.priceButton.enabled = false
        
        cell.homeButton.addTarget(self, action: #selector(VacationCollectionView.returnHome), forControlEvents: .TouchUpInside)
        
        if favoritesStore.favoriteLocations.isEmpty {
            
            cell.readMoreButton.hidden = true
            cell.readMoreButton.enabled = false
            
            cell.favoriteButton.hidden = true
            cell.favoriteButton.enabled = false
            
            cell.locationLabel.hidden = true
            cell.imageView.hidden = true
            
            cell.snippetLabel.text = "You do not have any destinations stored in favorites."
            cell.snippetLabel.textAlignment = .Center
            cell.snippetLabel.font = wanderSparkFont(25)
            
            
            return cell
            
        } else {
            cell.readMoreButton.addTarget(self, action: #selector(FavoritesCollectionView.goToArticle), forControlEvents: .TouchUpInside)
            
            let favoriteLocation = favoritesStore.favoriteLocations[indexPath.row]
            
            if let favoriteName = favoriteLocation.name {
                cell.locationLabel.text = favoriteName
            }
            
            if let favoriteSnippet = favoriteLocation.snippet {
                cell.snippetLabel.text = favoriteSnippet
            }
            
            cell.imageView.image = favoriteImages[indexPath.row]
            cell.backgroundLocationImage.image = favoriteImages[indexPath.row]
            
            if favoriteLocation.favorite == true {
                cell.favoriteButton.setTitle("◉", forState: .Normal)
            } else {
                cell.favoriteButton.setTitle("◎", forState: .Normal)
            }
            
            cell.favoriteButton.addTarget(self, action: #selector(FavoritesCollectionView.deleteFromFavorites), forControlEvents: .TouchUpInside)
            
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
        
        if let selectedIndex = favoritesCollectionView.indexPathForCell(selectedCell) {
            let selectedRow = selectedIndex.row
            
            let selectedFavorite = favoritesStore.favoriteLocations[selectedRow]
            
            selectedFavorite.toggleFavoriteStatus()
            selectedCell.toggleFavoriteButton()
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        for favorite in favoritesStore.favoriteLocations {
            if favorite.favorite == false {
                favoritesStore.managedObjectContext.deleteObject(favorite)
            }
        }
        favoritesStore.saveContext()
    }
    
    
    func goToArticle(){
        let selectedCell = favoritesCollectionView.visibleCells()[0] as! customVacationCell
        guard let selectedIndex = favoritesCollectionView.indexPathForCell(selectedCell) else {
            print("Error: Cannot unwrap indexpath for selected favorite collection view cell.")
            return
        }
        
        if let urlString = favoritesStore.favoriteLocations[selectedIndex.row].articleURL {
            if let url = NSURL(string: urlString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
}
