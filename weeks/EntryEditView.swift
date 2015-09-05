//
//  EntryViewController.swift
//  weeks
//
//  Created by Will on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation

@IBDesignable class EntryEditView: UIView {
    let dateButton = UIButton()
    let datePicker = UIDatePicker()
    var datePickerConstraint: NSLayoutConstraint!
    let pictureButton = UIButton()
    let titleField = UITextField()
    let summaryTextView = UITextView()
    
    var date = NSDate()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setupConstraints() {
        datePickerConstraint = NSLayoutConstraint(item: datePicker,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        dateButton.setTitle("Set Date", forState: .Normal)
        dateButton.addTarget(self, action: "pickDate", forControlEvents: .TouchUpInside)
//        pictureButton.setTitle("Add Picture", forState: .Normal)
        pictureButton.setImage(UIImage(named: "Camera"), forState: .Normal)
        pictureButton.addTarget(self, action: "pickPicture", forControlEvents: .TouchUpInside)
        
        dateButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        datePicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        pictureButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleField.setTranslatesAutoresizingMaskIntoConstraints(false)
        summaryTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        titleField.placeholder = "Title"
        titleField.textAlignment = .Center
        
        dateButton.setTitleColor(tintColor, forState: .Normal)
        pictureButton.setTitleColor(tintColor, forState: .Normal)
        
        addSubview(dateButton)
        addSubview(datePicker)
        addSubview(pictureButton)
        addSubview(titleField)
        addSubview(summaryTextView)
        addConstraints([
            // titleField
            NSLayoutConstraint(item: self,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: titleField,
                attribute: .Top,
                multiplier: 1,
                constant: -8),
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: titleField,
                attribute: .Left,
                multiplier: 1,
                constant: -8),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: titleField,
                attribute: .Right,
                multiplier: 1,
                constant: 8),
            
            // dateButton
            NSLayoutConstraint(item: titleField,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: dateButton,
                attribute: .Top,
                multiplier: 1,
                constant: -8),
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: dateButton,
                attribute: .Left,
                multiplier: 1,
                constant: -8),
            
            // pictureButton
            NSLayoutConstraint(item: titleField,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: pictureButton,
                attribute: .Top,
                multiplier: 1,
                constant: -8),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: pictureButton,
                attribute: .Right,
                multiplier: 1,
                constant: 8),
            
            
            //datePicker
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: datePicker,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: datePicker,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            datePickerConstraint,
            
            // summaryTextView
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: summaryTextView,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: summaryTextView,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: dateButton,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: summaryTextView,
                attribute: .Top,
                multiplier: 1,
                constant: -8),
            NSLayoutConstraint(item: datePicker,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: summaryTextView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0),
            ]
        )
        updateDateLabel()
    }

    func updateDateLabel() {
        let fmt = NSDateFormatter()
        fmt.locale = NSLocale.currentLocale()
        fmt.dateStyle = NSDateFormatterStyle.ShortStyle
        let str = fmt.stringFromDate(date)
        dateButton.setTitle(str, forState: .Normal)
        dateButton.titleLabel?.font = UIFont.italicSystemFontOfSize(16)
    }
    
    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupConstraints()
    }
    
    
    func pickPicture() {
        
    }
    
    func pickDate() {
        if datePickerConstraint.constant < 0 {
            // roll down
            datePickerConstraint.constant = 0
            date = datePicker.date
        } else {
            // roll up
            datePickerConstraint.constant = -datePicker.frame.height
        }
        UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.layoutIfNeeded()
        }, completion: nil)
        updateDateLabel()
    }
}