//
//  CxTableViewCell.swift
//  SeeNow
//
//  Created by apple on 14/12/5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit

class CxTableViewCell: UITableViewCell {


    @IBOutlet weak var test: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       // self.addSubview(label1)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
