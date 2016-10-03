//
//  TabbarController.swift
//  uSecure
//
//  Created by Kevin Grozav on 9/29/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // add view controllers to tabbar
        let layout = UICollectionViewFlowLayout()
        let groupsContoller = GroupMessagesController(collectionViewLayout: layout)
        let messagesNav = NavbarController(rootViewController:  groupsContoller)
        messagesNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "message"), selectedImage: UIImage(named: "message"))
        
        let alarmController = AlarmController()
        let alarmNav = NavbarController(rootViewController: alarmController)
        alarmNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"alarm"), selectedImage: UIImage(named: "alarm"))
       
        
        let reminderController = ReminderContoller()
        let reminderNav = NavbarController(rootViewController: reminderController)
        reminderNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"reminder"), selectedImage: UIImage(named: "reminder"))
        
         self.viewControllers = [messagesNav, alarmNav, reminderNav]
        
        // set the appearance of tabbar
        // the selected tabbar button will be a lighter color
        UITabBar.appearance().tintColor = UIColor.florianOrange
        let numberOfItems = CGFloat(self.tabBar.items!.count)
        let tabBarItemSize = CGSize(width: self.tabBar.frame.width / numberOfItems, height: self.tabBar.frame.height)
        self.tabBar.selectionIndicatorImage = UIImage.imageWithColor(UIColor.florianOrange, size: tabBarItemSize).resizableImageWithCapInsets(UIEdgeInsetsZero)
        // the remaining tabbar buttons will be a darker color
        self.tabBar.barTintColor = UIColor(red: 231/256, green: 91/256, blue: 76/256, alpha: 1)
        self.tabBar.translucent = false
        
        
        // set the color of the unselected items to white
        self.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.whiteColor(), size: CGSizeMake(self.tabBar.frame.width/CGFloat(tabBar.items!.count), self.tabBar.frame.height))
        
        // To change tintColor for unselect tabs
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        
        
    }
}

class NavbarController : UINavigationController {
    
    override func viewDidLoad() {
        self.navigationBar.barTintColor = UIColor.florianCream
        self.navigationBar.translucent = false
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.florianOrange]
    }
}
