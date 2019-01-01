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
    
    func setData(withElement element: Element) {
        nameLabel.text = element.name!
        descriptionTextView.text = element.description!
        if element.isFavorite {
            contentView.backgroundColor = UIColor.yellow
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
}
