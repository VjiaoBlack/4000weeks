//
//  EntryCollectionView.swift
//  weeks
//
//  Created by Will on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation
import UIKit

let kEntryCellIdentifier = "kEntryCellIdentifier"

class EntryTableViewCell: UITableViewCell {
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var summaryLabel = UILabel()
    
    var entry: Entry? {
        didSet {
            titleLabel.text = " "+entry!.title
            //photoView.image = UIImage(data: entry!.picture)
            let fmt = NSDateFormatter()
            fmt.locale = NSLocale.currentLocale()
            fmt.dateStyle = NSDateFormatterStyle.ShortStyle
            dateLabel.text = " "+fmt.stringFromDate(NSDate(timeIntervalSince1970: entry!.date))
            
            summaryLabel.text = entry?.summary
            backgroundView = UIImageView(image: UIImage(data: entry!.picture))
            backgroundView!.clipsToBounds = true
            backgroundView!.contentMode = UIViewContentMode.ScaleAspectFill
        }
    }
    
    class func desiredHeight(forEntry e: Entry, width: CGFloat) -> CGFloat {
        let attrs: [NSString:AnyObject] = [NSFontAttributeName:UIFont(name: "Palatino", size: 18)!]
        let text = e.summary as NSString
        let size = text.boundingRectWithSize(CGSize(width: width - 16, height: CGFloat.max),
            options: NSStringDrawingOptions.allZeros,
            attributes: attrs, context: nil)
        return min(size.height + 96, 200)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let labels = [titleLabel, dateLabel, summaryLabel]
        for v in labels {
            v.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(v)
            v.textColor = UIColor.whiteColor()
        }
        
        titleLabel.textAlignment = .Center
//        var f = titleLabel.frame
//        f.size.width = frame.width
//        f.size.height = 44
//        f.origin = CGPointZero
//        titleLabel.frame = f
//        
//        dateLabel.frame = CGRect(x: 0, y: 52, width: frame.width, height: 34)
    
        let constraints = [
            //title
            NSLayoutConstraint(item: contentView, attribute: .Left, relatedBy: .Equal, toItem: titleLabel, attribute: .Left, multiplier: 1, constant: 32),
            NSLayoutConstraint(item: contentView, attribute: .Right, relatedBy: .Equal, toItem: titleLabel, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44),
            
            // dateLabel
            NSLayoutConstraint(item: contentView, attribute: .Left, relatedBy: .Equal, toItem: dateLabel, attribute: .Left, multiplier: 1, constant: 32),
            NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: dateLabel, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dateLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 32),
            
            // summaryLabel
            NSLayoutConstraint(item: contentView, attribute: .Bottom, relatedBy: .Equal, toItem: summaryLabel, attribute: .Bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: contentView, attribute: .Left, relatedBy: .Equal, toItem: summaryLabel, attribute: .Left, multiplier: 1, constant: 32),
            NSLayoutConstraint(item: contentView, attribute: .Right, relatedBy: .Equal, toItem: summaryLabel, attribute: .Right, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: dateLabel, attribute: .Bottom, relatedBy: .Equal, toItem: summaryLabel, attribute: .Top, multiplier: 1, constant: 8)
            
            
        ]
        
        addConstraints(constraints)
    }
    
}

class EntryTableViewController: UITableViewController {
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBOutlet weak var centerButton: UIBarButtonItem!

    var date: NSDate = NSDate() {
        didSet {
            let firstSeconds = date.zeroSecond().timeIntervalSince1970
            let lastSeconds = date.lastSecond().timeIntervalSince1970
            let f: Entry -> Bool = { e in
                
                return  (e.date <= lastSeconds) && (e.date >= firstSeconds)
            }
            entries = Entry.fetch().filter(f)
            let fmt = NSDateFormatter()
            fmt.locale = NSLocale.currentLocale()
            fmt.dateStyle = NSDateFormatterStyle.ShortStyle
            leftButton.title = fmt.stringFromDate(NSDate(timeIntervalSince1970: firstSeconds - 5000))
            rightButton.title = fmt.stringFromDate(NSDate(timeIntervalSince1970: lastSeconds + 5000))
            centerButton.title = fmt.stringFromDate(date)
            tableView.reloadData()
        }
    }
    
    var entries: [Entry] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        date = NSDate()
        tableView.reloadData()

        centerButton.tintColor = UIColor.blackColor()
        centerButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func tomorrow() {
        let lastSeconds: NSTimeInterval = date.lastSecond().timeIntervalSince1970
        let c: Bool -> () = { _ in
//            self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.width/2, 0)
            UIView.animateWithDuration(0.1, animations: {
                self.tableView.layer.transform = CATransform3DIdentity
                self.date = NSDate(timeIntervalSince1970: lastSeconds + 5000)
                self.view.alpha = 1
            })
        }
        UIView.animateWithDuration(0.1,
            animations: {
//                self.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.width/2, 0)
                self.tableView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 1, 0)
             self.view.alpha = 0.75
            }, completion: c)

    }
    
    @IBAction func yesterday() {
        let zeroSeconds: NSTimeInterval = date.zeroSecond().timeIntervalSince1970
        let c: Bool -> () = { _ in
//            self.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.width/2, 0)
            UIView.animateWithDuration(0.1, animations: {
                //self.view.transform = CGAffineTransformIdentity
                self.tableView.layer.transform = CATransform3DIdentity
                self.date = NSDate(timeIntervalSince1970: zeroSeconds - 5000)
                self.view.alpha = 1
            })
        }
        UIView.animateWithDuration(0.1,
            animations: {
                //self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.width/2, 0)
                self.tableView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_4), 0, 1, 0)
                self.view.alpha = 0.75
            }, completion: c)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(kEntryCellIdentifier, forIndexPath: indexPath) as! EntryTableViewCell
        cell.entry = entries[indexPath.row]
        cell.subviews.first?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return EntryTableViewCell.desiredHeight(forEntry: entries[indexPath.row], width: view.frame.width)
    }
    
}