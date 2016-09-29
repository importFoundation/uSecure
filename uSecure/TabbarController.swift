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
        
        let layout = UICollectionViewFlowLayout()
        let groupsContoller = GroupMessagesController(collectionViewLayout: layout)
        let messagesNav = UINavigationController(rootViewController:  groupsContoller)
        messagesNav.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "message"), selectedImage: UIImage(named: "message"))
        
        self.viewControllers = [messagesNav]
        
  
    }


}
