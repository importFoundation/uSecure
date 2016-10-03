//
//  ReminderContoller.swift
//  uSecure
//
//  Created by Kevin Grozav on 9/30/16.
//  Copyright © 2016 Kevin Grozav. All rights reserved.
//

import UIKit

/* Displays Reminders */
class ReminderContoller: BaseTableViewController {
    
    override func prepareNavComponents() {
        self.tableView.registerClass(ReminderCell.self, forCellReuseIdentifier: "ReminderCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(ReminderContoller.addReminder))
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.florianOrange
        self.navigationItem.title = "Reminders"
    }
    
   func addReminder() {
    let alert = UIAlertController(title: "Add Reminder", message: "This will enable the user to add a custom reminder notification", preferredStyle: .Alert)
    let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alert.addAction(ok)
    self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderCell", forIndexPath: indexPath) as! ReminderCell
        return cell
    }
    
    // MARK - Table view delegate for row actions
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailContrller = UIAlertController(title: "Organizational Reminder", message: "Tapping an reminder will provide a description of the reiminder", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: nil)
        detailContrller.addAction(okAction)
        detailContrller.addAction(editAction)
        detailContrller.view.tintColor = UIColor.florianOrange
        self.presentViewController(detailContrller, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit") { (action:UITableViewRowAction, index:NSIndexPath) in
            let alert = UIAlertController(title: "Edit", message: "This will enable the user to edit the alarm set in the group.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        editAction.backgroundColor = UIColor.florianOrange
        return [editAction]
    }
    
 
}


class ReminderCell : BaseTableCell {
    
    var reminderTitle : UILabel = {
        let title = UILabel()
        title.text = "Task Reminder"
        title.textColor = UIColor.florianOrange
        title.font = UIFont.boldSystemFontOfSize(16)
        return title
    }()
    
    var timeLabel : UILabel = {
        let time = UILabel()
        time.text = "8.00 pm"
        time.textColor = UIColor.florianOrange
        time.font = UIFont.boldSystemFontOfSize(16)
        return time
    }()
    
    var container : UIView = {
        let view = UIView()
        return view
    }()
    
    override func prepareLayout() {
        self.container.addSubview(reminderTitle)
        self.container.addSubview(timeLabel)
        self.container.addConstraintsWithFormat("H:|-30-[v0]|", views: self.timeLabel)
        self.container.addConstraintsWithFormat("H:|-30-[v0]|", views: reminderTitle)
        self.container.addConstraintsWithFormat("V:|-24-[v0][v1]", views: self.timeLabel, self.reminderTitle)
        self.addSubview(container)
        self.addConstraintsWithFormat("H:|[v0][v1(24)]-8-|", views: self.container, infoImageView)
        self.addConstraintsWithFormat("V:|[v0]|", views: self.container)
        self.addConstraintsWithFormat("V:[v0(24)]", views: infoImageView)
    }
    
    
}
