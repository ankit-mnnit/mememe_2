//
//  CollectionViewController.swift
//  Meme Me
//
//  Created by Ankit Garg on 16/05/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes:[Meme]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        println("memes count: \(self.memes.count)")
        self.collectionView.reloadData()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCellIdentifier", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.memedImage.image = self.memes[indexPath.row].memedImage
        cell.memedImage.contentMode = .ScaleAspectFill
        cell.label.text = memes[indexPath.row].topText
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        //(UIApplication.sharedApplication().delegate as! AppDelegate).meme = memes[indexPath.row]
        
        /* Push the meme detail view */
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMe") as! MemeMeDetailViewController
        
        controller.meme = memes[indexPath.row]
        
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeNav") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
}
