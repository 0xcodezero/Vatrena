//
//  Extensions.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 8/7/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadingImageUsingCache(withURLString urlString:String){
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        if urlString == "" {
            return
        }
        
        // Otherwise There will be downloading Request has to be done
        if let url = URL(string: urlString){
            
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if (error != nil){
                    print("ERROR happens while trying to download Image")
                    return
                }
                
                // Drawing UI must aligned within the main thread
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: data!){
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    }
                }
                
            })
            
            task.resume()
        }
        
        
    }

}
