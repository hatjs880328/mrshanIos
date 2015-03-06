//
//  mycellOneTableViewCell.swift
//  SeeNow
//
//  Created by apple on 14/12/9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit

class mycellOneTableViewCell: UITableViewCell {
    var label = UILabel(frame: CGRect(x:22,y:22,width:120,height:120))
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
