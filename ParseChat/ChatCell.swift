//
//  ChatCell.swift
//  ParseChat
//
//  Created by Tianyu Liang on 3/4/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var textMessage: UILabel!
    
    @IBOutlet weak var user: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
