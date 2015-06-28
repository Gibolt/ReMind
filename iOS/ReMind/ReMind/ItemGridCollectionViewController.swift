//
//  ItemGridCollectionViewController.swift
//  ReMind
//
//  Created by developer on 6/27/15.
//  Copyright (c) 2015 BattleHack. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

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

extension NSMutableData {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// :param: string       The string to be added to the `NSMutableData`.
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let selectedAsset = fetchResult!.objectAtIndex(indexPath.row) as! PHAsset
        
        let manager = PHImageManager.defaultManager()
        let targetSize = CGSize(width: selectedAsset.pixelWidth, height: selectedAsset.pixelHeight)
        let deliveryOptions = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        let requestOptions = PHImageRequestOptions()
        
        requestOptions.deliveryMode = deliveryOptions
        
        manager.requestImageForAsset(selectedAsset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: requestResultHandler)
    }
    
    func requestResultHandler (image: UIImage!, properties: [NSObject: AnyObject]!) -> Void
    {
//        if SLComposeViewController.isAvailableForServiceType(S LServiceTypeTwitter)
//        {
//            let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            twitterController.setInitialText("Here's a photo from my album!")
//            twitterController.addURL(NSURL(string: "http://flexmonkey.blogspot.co.uk"))
//            twitterController.addImage(image)
//            
//            twitterController.completionHandler = twitterControllerCompletionHandler
//            
//            if let viewController = window?.rootViewController as? ViewController
//            {
//                viewController.presentViewController(twitterController, animated: true, completion: nil)
//            }
//        }
        
//        var request:NSURLRequest = createRequest(userid: "nakul", img: image)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
//            data, response, error in
//            if error != nil {
//                println(error)
////                errord(error)
//                return
//            }
//            var parseError: NSError?
//            let responseObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &parseError)
//            if let responseDictionary = responseObject as? NSDictionary {
////                success(responseDictionary)
//                NSLog("Successfully sent an Image")
//            } else {
//                NSLog("Failed to sent an Image")
//            }
//            
//        })
//        task.resume()
        

    }
    
    
    /// Create request
    ///
    /// :param: userid   The userid to be passed to web service
    /// :param: password The password to be passed to web service
    /// :param: email    The email address to be passed to web service
    ///
    /// :returns:         The NSURLRequest that was created
    
    func createRequest (#userid: String, img: UIImage) -> NSURLRequest {
        let param = [
            "user_id"  : userid]  // build your dictionary however appropriate
        
        let boundary = generateBoundaryString()
        
        let url = NSURL(string: "http://acm.party:3000/api/photo/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "SEND"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
//        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", paths: nil, image: img, boundary: boundary)
        
        var data:NSData? = UIImageJPEGRepresentation(img, 100)
        if data == nil {
            NSLog("Something's rong")
        }
        request.HTTPBody = photoDataToFormData(data!, boundary: boundary, fileName: "file")
        
        return request
    }
    
    /// Create body of the multipart/form-data request
    ///
    /// :param: parameters   The optional dictionary containing keys and values to be passed to web service
    /// :param: filePathKey  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// :param: paths        The optional array of file paths of the files to be uploaded
    /// :param: boundary     The multipart/form-data boundary
    ///
    /// :returns:            The NSData of the body of the request
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, paths: [String]?, image: UIImage?, boundary: String) -> NSData {
        let body = NSMutableData()
        var data:NSData!
        
        //convert UIImage to NSData
        if image != nil {
            data = UIImageJPEGRepresentation(image, 100)
        }
        
        // Append the body with params
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        // set upload image, name is the key of image
        body.appendString("\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"pen111.png\"\r\n")
        body.appendString("Content-Type: image/png\r\n\r\n")
        body.appendData(data)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// :returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
    // this is a very verbose version of that function
    // you can shorten it, but i left it as-is for clarity
    // and as an example
    func photoDataToFormData(data:NSData, boundary:String,fileName:String) -> NSData {
        var fullData = NSMutableData()
        
        // 1 - Boundary should start with --
        let lineOne = "--" + boundary + "\r\n"
        fullData.appendData(lineOne.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        // 2
        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        NSLog(lineTwo)
        fullData.appendData(lineTwo.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        // 3
        let lineThree = "Content-Type: image/jpg\r\n\r\n"
        fullData.appendData(lineThree.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        // 4
        fullData.appendData(data)
        
        // 5
        let lineFive = "\r\n"
        fullData.appendData(lineFive.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        // 6 - The end. Notice -- at the start and at the end
        let lineSix = "--" + boundary + "--\r\n"
        fullData.appendData(lineSix.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)!)
        
        return fullData
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
