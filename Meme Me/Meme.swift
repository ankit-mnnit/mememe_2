//
//  Meme.swift
//  Meme Me
//
//  Created by Ankit Garg on 15/05/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage!, memedImage: UIImage!) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
