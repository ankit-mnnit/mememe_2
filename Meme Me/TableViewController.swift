//
//  TableViewController.swift
//  Meme Me
//
//  Created by Ankit Garg on 15/05/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes:[Meme]!

    @IBOutlet weak var memeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        self.memeTableView.reloadData()
        //println("Inside table view controller: meme count \(memes.count)")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCellIdentifier") as! UITableViewCell
        
        cell.imageView?.image = self.memes[indexPath.row].memedImage
        cell.imageView?.contentMode = .ScaleAspectFill
        cell.detailTextLabel?.text = self.memes[indexPath.row].topText
        
        //println(cell.detailTextLabel?.text)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //(UIApplication.sharedApplication().delegate as! AppDelegate).meme = memes[indexPath.row]
        
        /* Push the meme detail view */
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMe") as! MemeMeDetailViewController

        controller.meme = memes[indexPath.row]
        
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    @IBAction func showMemeMeScreen(sender: AnyObject) {
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeNav") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
    }

}

