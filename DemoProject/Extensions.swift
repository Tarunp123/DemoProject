//
//  Extensions.swift
//  DemoProject
//
//  Created by Tarun Prajapati on 22/02/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache()

extension UIImageView {
    public func loadImageFromURL(urlString: String, forRowAtIndex rowNo: Int) {
        
        // check for cache
        if let cachedImage = imageCache.objectForKey((urlString + "-\(rowNo)") as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //Show network activity in status bar
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        //Downloading the image from server. Not Caching.
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            //Hide network activity from status bar
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            //Check for error
            if error != nil {
                print(error)
                return
            }
            
            //Update GUI
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                
                //Cache the downloaded image
                imageCache.setObject(image!, forKey: (urlString + "-\(rowNo)") as AnyObject)
            })
            
        }).resume()
    }
}