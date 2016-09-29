//
//  AlarmController.swift
//  uSecure
//
//  Created by Kevin Grozav on 9/29/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit


    private let reuseIdentifier = "Cell"
class AlarmController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        
        // Configure the cell
        return cell
    }
  

}
