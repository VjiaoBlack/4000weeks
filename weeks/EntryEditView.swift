//
//  EntryViewController.swift
//  weeks
//
//  Created by Will on 9/5/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import Foundation

protocol ImageReceiver {
    func receiveImage(image: UIImage)
}

protocol ImageProvider {
    // this method should eventuall call toReceiver.receiveImages()
    func provideImage(toReceiver: ImageReceiver)
    func saved()
}

class EntryEditView: UIView, ImageReceiver {
    let dateButton = UIButton()
    let datePicker = UIDatePicker()
    var datePickerConstraint: NSLayoutConstraint!
    let pictureButton = UIButton()
    let titleField = UITextField()
    let summaryTextView = UITextView()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    let pictureView = UIImageView()
    
    var date = NSDate()
    var image: UIImage?
    var imageDelegate: ImageProvider?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func setMainColor(color: UIColor) {
        
        cancelButton.backgroundColor = UIColor.redColor()
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        summaryTextView.backgroundColor = UIColor.clearColor()
        summaryTextView.tintColor = color
        summaryTextView.textColor = color
        titleField.tintColor = color
        titleField.textColor = color
        pictureButton.tintColor = color
        pictureButton.setTitleColor(color, forState: .Normal)
        dateButton.setTitleColor(color, forState: .Normal)
        datePicker.backgroundColor = UIColor.whiteColor()
    }
    
    func setupConstraints() {
        clipsToBounds = true
        datePickerConstraint = NSLayoutConstraint(item: datePicker,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: saveButton,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        dateButton.setTitle("Set Date", forState: .Normal)
        dateButton.addTarget(self, action: "pickDate", forControlEvents: .TouchUpInside)

        pictureButton.setTitle("Photo", forState: .Normal)
        pictureButton.addTarget(self, action: "pickPicture", forControlEvents: .TouchUpInside)
        
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.addTarget(self, action: "insertEntry", forControlEvents: .TouchUpInside)
        saveButton.backgroundColor = tintColor
        saveButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        
        dateButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        datePicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        pictureButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleField.setTranslatesAutoresizingMaskIntoConstraints(false)
        summaryTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        saveButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        pictureView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        cancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)

        blurView.alpha = 0
        
        
        titleField.placeholder = "Title"
        titleField.textAlignment = .Center
        
        titleField.font = UIFont(name: "Palatino", size: 24)
        summaryTextView.font = UIFont(name: "Palatino", size: 18)
        dateButton.titleLabel?.font = UIFont(name: "Palatino-Italic", size: 22)
        saveButton.titleLabel?.font = UIFont(name: "Palatino", size: 20)
        pictureButton.titleLabel?.font = UIFont(name: "Palatino-Italic", size: 22)

        summaryTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        setMainColor(UIColor.blackColor())
        
        saveButton.enabled = false
        
        addSubview(pictureView)
        addSubview(blurView)
        addSubview(dateButton)
        addSubview(datePicker)
        addSubview(pictureButton)
        addSubview(titleField)
        addSubview(summaryTextView)
        addSubview(saveButton)
        addSubview(cancelButton)
        addConstraints([
            // titleField
            NSLayoutConstraint(item: self,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: titleField,
                attribute: .Top,
                multiplier: 1,
                constant: -32),
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
//            NSLayoutConstraint(item: pictureButton, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0, constant: 50),
//            NSLayoutConstraint(item: pictureButton, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0, constant: 50),
            
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
            
            // saveButton
            NSLayoutConstraint(item: self,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: saveButton,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: saveButton,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: saveButton,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0),
            
            // cancelButton
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: cancelButton,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: cancelButton,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: cancelButton,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0),
            
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

            // blurView
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: blurView,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: blurView,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: blurView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: blurView,
                attribute: .Top,
                multiplier: 1,
                constant: 0),

            // pictureView
            NSLayoutConstraint(item: self,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: pictureView,
                attribute: .Left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: pictureView,
                attribute: .Right,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: pictureView,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: pictureView,
                attribute: .Top,
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
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
    }
    
    func cancel() {
        imageDelegate?.saved()
    }
    
    func insertEntry() {
        let e = Entry.insertNew()
        e.date = date.timeIntervalSince1970
        e.summary = summaryTextView.text
        e.title = titleField.text
        e.picture = UIImagePNGRepresentation(image)
        Entry.saveContext()
        imageDelegate?.saved()
/*
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.allZeros,
            animations: {
                self.transform = CGAffineTransformMakeScale(0.3, 0.3)
                self.alpha = 0.5
            }, completion: {
                complete in
                UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .allZeros, animations: {
                    self.date = NSDate()
                    self.summaryTextView.text = ""
                    self.titleField.text = ""
                    self.updateDateLabel()
                    self.image = nil
                    self.transform = CGAffineTransformIdentity
                    self.alpha = 1
                    }, completion: nil)
        })*/
    }
    
    func pickPicture() {
        imageDelegate?.provideImage(self)
    }
    
    func receiveImage(image: UIImage) {
        self.image = image
        pictureView.image = image
        blurView.alpha = 1
        setMainColor(UIColor.whiteColor())
        saveButton.enabled = true
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

class EntryTestVC: UIViewController, ImageProvider, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var eview: EntryEditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eview.imageDelegate = self
    }
    
    func saved() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func provideImage(toReceiver: ImageReceiver) {
        let picker = UIImagePickerController()
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        eview.receiveImage(image)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}