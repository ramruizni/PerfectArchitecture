//
//  DetailViewController.swift
//  PerfectArchitecture
//
//  Created by valid on 12/28/18.
//  Copyright © 2018 valid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, StoryboardInitializable {
    
    var name: String = "asd"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        
    }

}
