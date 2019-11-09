//
//  userTableViewCell.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/28/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import UIKit

class userTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userImage: UIImageViewRounded!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
