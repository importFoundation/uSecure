//
//  AlarmController.swift
//  uSecure
//
//  Created by Kevin Grozav on 9/29/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit

class AlarmController: BaseTableViewController {

    // MARK: BaseTableViewContoller overrides
    override func prepareNavComponents() {
        self.tableView.registerClass(AlarmCell.self, forCellReuseIdentifier: "AlarmCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(AlarmController.addAlarm))
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.florianOrange
        self.navigationItem.title = "Alarms"
    }
   
    
    func addAlarm() {
        let alert = UIAlertController(title: "Add Alarm", message: "This will enable the user to add a custom alarm notification", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlarmCell", forIndexPath: indexPath) as! AlarmCell
        
        return cell
    }
    
    
   // MARK - Table view delegate for row actions
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailContrller = UIAlertController(title: "Organizational Alarm", message: "Tapping an alarm will provide a description of the alarm", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: nil)
        detailContrller.addAction(okAction)
        detailContrller.addAction(editAction)
        detailContrller.view.tintColor = UIColor.florianOrange
        self.presentViewController(detailContrller, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let launchAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Launch") { (action:UITableViewRowAction, index:NSIndexPath) in
            let alert = UIAlertController(title: "Launch", message: "This will launch a push notifications to alert all members in the group. ", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        launchAction.backgroundColor = UIColor.florianOrange
        return [launchAction]
    }


}




/* All TableViewControllers will implement this class to ensure a simillar layout and enable code reuse */
class BaseTableViewController : UITableViewController {
    
    /* each subclass will override prepareComponents */
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavComponents()
    }
    
    // must be overriden by subclass
    func prepareNavComponents() {}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /* The table views will conform to one designated layout, where each row is its own section, sperator by a footer */
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView =  UIView()
        footerView.backgroundColor = UIColor.florianOrange
        return footerView
    }

    /* table views in the application will support row edititing by default */
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    /* Each table view in the application will be a uniform height */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
}


/* Factors initilization into base class */
class BaseTableCell : UITableViewCell {
    
    // declared properties
    var infoConstraint : NSLayoutConstraint? = nil
    
    
    // computer initializers
    var infoImageView : UIImageView = {
        let imgView = UIImageView()
        let unrenderedImage = UIImage(named: "info")
        let renderedImage = unrenderedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imgView.image = renderedImage
        imgView.tintColor = UIColor.florianOrange
        imgView.layer.cornerRadius = 12
        imgView.layer.masksToBounds = true
        imgView.contentMode = .ScaleToFill
        
        return imgView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.addSubview(self.infoImageView)
        self.infoConstraint = NSLayoutConstraint(item: infoImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        self.addConstraint(self.infoConstraint!)
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* enables custimatization for each subclass overriding this func */
    func prepareLayout() {}
}


/* The cell displayed in the AlarmController */
class AlarmCell : BaseTableCell {
    
    /* Computed Initilizers */
    var alarmTitle : UILabel = {
        let title = UILabel()
        title.text = "Organizational Alarm"
        title.textColor = UIColor.florianOrange
        title.font = UIFont.boldSystemFontOfSize(16)
        return title
    }()
    
    // override for custimazation
    override func prepareLayout() {
        super.prepareLayout()
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(alarmTitle)
        self.addSubview(infoImageView)
        self.addConstraintsWithFormat("H:|-12-[v0][v1(24)]-32-|", views: self.alarmTitle, self.infoImageView)
        self.addConstraintsWithFormat("V:|[v0]|", views: self.alarmTitle)
        self.addConstraintsWithFormat("V:[v0(24)]", views: self.infoImageView)
    }
    
   
    
}




