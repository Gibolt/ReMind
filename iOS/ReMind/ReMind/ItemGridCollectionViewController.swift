//
//  ItemGridCollectionViewController.swift
//  ReMind
//
//  Created by developer on 6/27/15.
//  Copyright (c) 2015 BattleHack. All rights reserved.
//

import UIKit
import Photos

extension ItemGridCollectionViewController : UICollectionViewDelegateFlowLayout {

    // Following fucntion is used to specify image size
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//            
//            let flickrPhoto =  UIImage()
//            //2
//            if var size = flickrPhoto.thumbnail?.size {
//                size.width += 10
//                size.height += 10
//                return size
//            }
//            return CGSize(width: 100, height: 100)
//    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //  Adding border by uncommenting the following. Don't forget to add
        //      border indent and remove border constraint in Main.storyboard.
//            return sectionInsets
            return UIEdgeInsetsZero
    }
}

class ItemGridCollectionViewController: UICollectionViewController {
    
    let reuseIdentifier = "Cell"
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    
    var images:NSMutableArray! // <-- Array to hold the fetched images
    var currDate:NSDate! // <-- Establishes current day and time
    var fetchResult:PHFetchResult!
    
    func fetchPhotos () {
        currDate = NSDate.init()
        images = NSMutableArray()
        
        // The following will always create a time range from the beginning of the day
        //  at 00:00:00 to the current time defined as endDate
        let endDate:NSDate = currDate
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let startDate:NSDate = cal!.startOfDayForDate(endDate)
        
        var fetchOptions:PHFetchOptions  = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "creationDate > %@ AND creationDate < %@ AND mediaType == %d", startDate, endDate, PHAssetMediaType.Image.rawValue)

        fetchResult = PHAsset.fetchAssetsWithOptions(fetchOptions)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment following when fetching photos from library
        self.fetchPhotos()
        
        NSLog("PhotoResult size within function: %d", fetchResult!.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return fetchResult!.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ItemGridCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ItemGridCollectionCell
    
        let asset = fetchResult!.objectAtIndex(indexPath.row) as! PHAsset

        cell.asset = asset
        
        return cell
    
        // Configure the cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
