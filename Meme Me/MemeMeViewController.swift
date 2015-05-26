//
//  MemeMeViewController.swift
//  Meme Me
//
//  Created by Ankit Garg on 16/05/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import Foundation
import UIKit

class MemeMeViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!

    @IBOutlet weak var bottomTextField: UITextField!

    @IBOutlet weak var cameraImagePicker: UIBarButtonItem!
    @IBOutlet weak var imageViewPicker: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBAction func cancelMeme(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewPicker.hidden = true
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 2.0
        ]
        
        topTextField.text = "TOP"
        topTextField.delegate = self
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.defaultTextAttributes = memeTextAttributes
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.delegate = self
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        self.shareButton.enabled = false
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.cameraImagePicker.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        
        
        self.subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        //println(notification)
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        if bottomTextField.editing {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
            return keyboardSize.CGRectValue().height
        } else {
            return 0
        }
    }
    
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.shareButton.enabled = true
        self.imageViewPicker.hidden = false
        self.imageViewPicker.image = image
        self.imageViewPicker.contentMode = .ScaleAspectFill
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func pickAnImageCamera(sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" {
            textField.text = ""
        } else if textField.text == "BOTTOM" {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func save(sender: AnyObject) {
        var memedImage: UIImage! = generateMemedImage()
        
        var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageViewPicker.image, memedImage: memedImage)
        
        print(meme.topText)
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        println((UIApplication.sharedApplication().delegate as! AppDelegate).memes.count)
        
//        let collectionViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeCollectionViewController") as! MemeCollectionViewController
//        //detailController.villain = self.allVillains[indexPath.row]
//        self.navigationController!.pushViewController(collectionViewController, animated: true)

        let activityViewController = UIActivityViewController(activityItems: [topTextField.text!], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.toolbar.hidden = true
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.toolbar.hidden = false
        
        return memedImage
    }}
