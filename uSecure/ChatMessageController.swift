//
//  ChatMessageController.swift
//  uSecure
//
//  Created by Kevin Grozav on 9/23/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit



class ChatMessageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    private let cellId : String = "cellId"
    
    var messages : [Message] = [Message]()
    
    var containerView : UIView = {
       let container = UIView()
        container.backgroundColor = UIColor.whiteColor()
        return container
    }()
    
    var inputTextField : UITextField = {
        let input = UITextField()
        input.backgroundColor = UIColor.clearColor()
        input.placeholder = "Enter message..."
        return input
    }()
    
    var sendButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("send", forState: .Normal)
        btn.setTitleColor(UIColor.florianOrange, forState: .Normal)
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        return btn
    }()
    
    var bottomContainerConstraint : NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        self.collectionView?.alwaysBounceVertical = true
        
        // hardcoded data
        self.messages.append(Message(messageID: "1", messageContent: "This is the first message of three more messages which are below it", messageSender: "me", messageImageURL: nil, isSender: false))
        self.messages.append(Message(messageID: "1", messageContent: "This is the second Message", messageSender: "me", messageImageURL: nil, isSender: true))
        self.messages.append(Message(messageID: "1", messageContent: "Lorem Ipsum dolor et so.Lorem Ipsum dolor et so.Lorem Ipsum dolor et so.Lorem Ipsum dolor et so.Lorem Ipsum dolor et so.Lorem Ipsum dolor et so. ", messageSender: "me", messageImageURL: nil, isSender: false))
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        // Register cell classes
        self.collectionView!.registerClass(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        
        // add subviews with constraints
        self.view.addSubview(self.containerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: containerView)
        self.view.addConstraintsWithFormat("V:[v0(48)]", views: containerView)
        self.bottomContainerConstraint = NSLayoutConstraint(item: containerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(self.bottomContainerConstraint!)
        
       
        
        setupInterfaceComponents()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleKeyboard), name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleKeyboard), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func handleKeyboard(notification: NSNotification) {
        if let userinfo = notification.userInfo {
            let keyboardFrame = userinfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            let isShowing = notification.name == UIKeyboardWillShowNotification
            print(keyboardFrame!.height)
            self.bottomContainerConstraint?.constant = isShowing ?  -keyboardFrame!.height : 0
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                self.view.layoutIfNeeded()
                }, completion: { (completed) in
                        let indexPath = NSIndexPath(forItem: self.messages.count - 1, inSection: 0)
                        self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
            })
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupInterfaceComponents() {
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        
        self.containerView.addSubview(self.inputTextField)
        self.containerView.addSubview(self.sendButton)
        self.containerView.addSubview(seperator)
        self.containerView.addConstraintsWithFormat("H:|-8-[v0][v1(60)]|", views: self.inputTextField, self.sendButton)
        self.containerView.addConstraintsWithFormat("V:|[v0]|", views: self.inputTextField)
        self.containerView.addConstraintsWithFormat("V:|[v0]|", views: self.sendButton)
        
        
        self.containerView.addConstraintsWithFormat("H:|[v0]|", views: seperator)
        self.containerView.addConstraintsWithFormat("V:|[v0(0.5)]", views: seperator)
    }

    
    
     // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.inputTextField.endEditing(true)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ChatMessageCell
        let message = messages[indexPath.row]
        let content = message.messageContent
        let size = CGSizeMake(200,1000)
        let options = NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin)
        let estimatedFrame = NSString(string: content).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        
        if !message.isSender {
            cell.messageTxtView.frame = CGRectMake(88, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            cell.bubbleView.frame = CGRectMake(80, 0, estimatedFrame.width + 24, estimatedFrame.height + 20)
            cell.profileImageView.hidden = false
            cell.usernameLbl.hidden = false
        } else {
            cell.messageTxtView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 24, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            cell.bubbleView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 32, 0, estimatedFrame.width + 24, estimatedFrame.height + 20)
            cell.bubbleView.backgroundColor = UIColor.florianOrange
            cell.messageTxtView.textColor = UIColor.whiteColor()
            cell.profileImageView.hidden = true
            cell.usernameLbl.hidden = true
        }
        
       

        cell.messageTxtView.text = messages[indexPath.row].messageContent
        return cell
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let content = messages[indexPath.row].messageContent
        let size = CGSizeMake(200, 1000)
        let options = NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin)
        let estimatedFrame = NSString(string: content).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        return CGSizeMake(view.frame.width, estimatedFrame.height + 20)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8,0,0,0)
    }
}


class ChatMessageCell : BaseCell {
    
    let messageTxtView : UITextView = {
       let message = UITextView() 
        message.text = "Lorem Ipsum Dolor et. Lorem Ipsum Dolor et. Lorem Ipsum Dolor et. Lorem Ipsum Dolor et."
        message.font = UIFont.systemFontOfSize(16)
        message.backgroundColor = UIColor.clearColor()
        return message
    }()
    
    let bubbleView : UIView = {
        let bubble = UIView()
        bubble.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bubble.layer.cornerRadius = 15
        bubble.layer.masksToBounds = true
        return bubble
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "profilePic")
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let usernameLbl : UILabel = {
       let name = UILabel()
        name.text = "Kevin Grozav"
        name.font = UIFont.systemFontOfSize(10)
        name.textColor = UIColor.lightGrayColor()
        return name
    }()
    
    override func prepareLayout() {
        super.prepareLayout()
        self.addSubview(bubbleView)
        self.addSubview(messageTxtView)
        self.addSubview(profileImageView)
        self.addSubview(usernameLbl)
    
        self.addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        self.addConstraintsWithFormat("H:|-8-[v0(90)]", views: usernameLbl)
        self.addConstraintsWithFormat("V:[v0(30)]-2-[v1(40)]|", views: profileImageView, usernameLbl)
//        self.addConstraintsWithFormat("H:[v0(100)]|", views: usernameLbl)
//        self.addConstraintsWithFormat("V:[v0]|", views: usernameLbl)
    }
}

