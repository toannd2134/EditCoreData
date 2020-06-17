//
//  DataTableViewCell.swift
//  LearnCoreData
//
//  Created by Toan on 6/13/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
