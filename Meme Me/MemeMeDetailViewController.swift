//
//  MemeMeDetailViewController.swift
//  Meme Me
//
//  Created by Ankit Garg on 26/05/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import UIKit

class MemeMeDetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!

    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
    }
    
}
