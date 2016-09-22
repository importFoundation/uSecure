//
//  MessagesController.swift
//  uSecure
//
//  Created by Kevin Grozav on 9/4/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit



class MessagesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "MessageCell"
    
    //  MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.alwaysBounceVertical = true
        self.layoutViews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: User Interface Implementation
    private func layoutViews() {
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Messages"
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
       
        
        // Configure the cell
        return cell
    }
    
    
    //MARK:  UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 80)
    }

}



/* this cell displays the user's group and the most recent message in that group, along with its timestamp */
class MessageCell : BaseCell {
    
    /* computed initializers */
    
    let userImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .ScaleToFill
        imageView.image = UIImage(named: "profilePic")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let seperatorView : UIView = {
        let seperator = UIView()
        seperator.backgroundColor = UIColor.lightGrayColor()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        return seperator
    }()
    
    let usernameLbl : UILabel = {
        let username = UILabel()
        username.text = "Group Name"
        username.translatesAutoresizingMaskIntoConstraints = false
        return username
    }()
    
    
    let messageLbl : UILabel = {
        let message = UILabel()
        message.text = "This is a really looooong message"
        message.translatesAutoresizingMaskIntoConstraints = false
        message.textColor = UIColor.darkGrayColor()
        message.font = UIFont.systemFontOfSize(14.0)
        return message
    }()
    
    
    let timeStamp : UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = "5:00 pm"
        time.font = UIFont.systemFontOfSize(14.0)
        time.textAlignment = .Right
        return time
    }()
    
    /* called on init, sets layout for group message cell */
    override private func prepareLayout() {
        
        self.createContainerView()
        
        // add computer initializers to view heirarchy
        self.addSubview(self.userImageView)
        self.addConstraintsWithFormat("H:|-12-[v0(68)]", views: self.userImageView)
        self.addConstraintsWithFormat("V:[v0(68)]", views: self.userImageView)
        self.addConstraint(NSLayoutConstraint(item: self.userImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
       
        
        self.addSubview(self.seperatorView)
        self.addConstraintsWithFormat("H:|-82-[v0]|", views: self.seperatorView)
        self.addConstraintsWithFormat("V:[v0(1)]|", views: self.seperatorView)
        
        
        
    }
    
    /* create the container which holds the name, message, and timestamp */
    private func createContainerView() {
        //create the view
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        //create the constraints
        self.addConstraintsWithFormat("H:|-90-[v0]|", views: containerView)
        self.addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        self.addConstraint(NSLayoutConstraint(item: containerView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        //add views into the container
        containerView.addSubview(self.usernameLbl)
        containerView.addSubview(self.messageLbl)
        containerView.addSubview(self.timeStamp)
        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: self.usernameLbl, self.timeStamp)
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: self.usernameLbl, self.messageLbl)
        containerView.addConstraintsWithFormat("H:|[v0]-12-|", views: self.messageLbl)
        containerView.addConstraintsWithFormat("V:|[v0(20)]", views: self.timeStamp)
        
    }
}



/* Superclass which will be implemented by multiple cells for code reuse */
class BaseCell : UICollectionViewCell {
    
    // MARK: UICollectionViewCell overrides
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.prepareLayout()
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {}
    
}
