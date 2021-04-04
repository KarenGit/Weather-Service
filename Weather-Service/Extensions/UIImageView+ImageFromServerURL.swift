//
//  UIImageView+ImageFromServerURL.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/3.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil { return }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
