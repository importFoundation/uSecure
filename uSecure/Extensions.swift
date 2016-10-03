//
//  Extensions.swift
//  uSecure
//
//  Created by Kevin Grozav on 8/30/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit
extension UIColor {
    
    static var florianOrange: UIColor {
        return UIColor(red: 231/256, green: 91/256, blue: 76/256, alpha: 1)
    }
    
    static var florianCream: UIColor {
        return UIColor(red: 92.2, green: 92.2, blue: 92.2, alpha: 1)
    }
}


// This extention enables the selected tabBar button to be a different color
// code from stack over flow.
extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage!)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}




extension UIView {
    
    func addConstraintsWithFormat(format: String, views : UIView ...) {
        
        var formatViews =  [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            formatViews[key] = view
            formatViews[key]?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: formatViews))
    }
}

