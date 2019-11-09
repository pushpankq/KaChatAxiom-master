//
//  chatsTableViewCell.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/21/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import UIKit

class chatsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var userImage: UIImageViewRounded!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
