//
//  MainTableViewCell.swift
//  PerfectArchitecture
//
//  Created by valid on 12/27/18.
//  Copyright © 2018 valid. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    func setData(_ name: String, _ description: String) {
        nameLabel.text = name
        descriptionTextView.text = description
    }
    
}
