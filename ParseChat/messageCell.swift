//
//  messageCell.swift
//  ParseChat
//
//  Created by Nanxin Jin on 2/23/17.
//  Copyright © 2017 jinn. All rights reserved.
//

import UIKit

class messageCell: UITableViewCell {

    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
