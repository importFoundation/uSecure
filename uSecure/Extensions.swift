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

