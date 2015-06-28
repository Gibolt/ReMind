//
//  ItemGridCollectionCell.swift
//  ReMind
//
//  Created by developer on 6/27/15.
//  Copyright (c) 2015 BattleHack. All rights reserved.
//

import UIKit
import Photos

class ItemGridCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let manager = PHImageManager.defaultManager()
    let deliveryOptions = PHImageRequestOptionsDeliveryMode.Opportunistic
    let requestOptions = PHImageRequestOptions()
    let thumbnailSize = CGSize(width: 100, height: 100)
    
    var asset: PHAsset?
        {
        didSet
        {
            if let _asset = asset
            {
                requestOptions.deliveryMode = deliveryOptions
                
                manager.requestImageForAsset(_asset, targetSize: thumbnailSize, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: requestResultHandler)
            }
        }
    }
    
    func requestResultHandler (image: UIImage!, properties: [NSObject: AnyObject]!) -> Void
    {
        imageView.image = image
    }

}
