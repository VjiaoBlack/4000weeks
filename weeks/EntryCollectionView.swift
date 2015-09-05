//
//  EntryCollectionView.swift
//  weeks
//
//  Created by Will on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation

let kEntryCellIdentifier = "kEntryCellIdentifier"

@IBDesignable class EntryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            titleLabel.text = entry?.title
            photoView.image = UIImage(data: entry!.picture)
            let fmt = NSDateFormatter()
            fmt.locale = NSLocale.currentLocale()
            dateLabel.text = fmt.stringFromDate(NSDate(timeIntervalSince1970: entry!.date))
            summaryLabel.text = entry?.summary
        }
    }
    
    class func desiredHeight(forEntry e: Entry, width: CGFloat) -> CGFloat {
        let attrs: [NSString:AnyObject] = [NSFontAttributeName:UIFont(name: "Palatino", size: 18)!]
        let text = e.summary as NSString
        let size = text.boundingRectWithSize(CGSize(width: width - 16, height: CGFloat.max),
            options: NSStringDrawingOptions.allZeros,
            attributes: attrs, context: nil)
        return size.height + 96
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

class EntryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var date: NSDate = NSDate() {
        didSet {
            entries = Entry.fetch(date)
            collectionView?.reloadData()
        }
    }
    
    var entries: [Entry] = Entry.fetch(limit: 1)//(NSDate())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width,
            height: EntryCollectionViewCell.desiredHeight(forEntry: entries[indexPath.row], width: view.frame.width))
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kEntryCellIdentifier, forIndexPath: indexPath) as! EntryCollectionViewCell
        cell.entry = entries[indexPath.row]
        cell.subviews.first?.setTranslatesAutoresizingMaskIntoConstraints(false)
        var f = cell.frame
        f.size.width = view.frame.width
        f.size.height = EntryCollectionViewCell.desiredHeight(forEntry: entries[indexPath.row], width: f.width)
        cell.frame = f
        
        return cell
    }
    
    
}