//
//  EventTBCell.swift
//  Erbienbi
//
//  Created by juan.enriquez on 16/10/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import UIKit

class EventTBCell: UITableViewCell {
    @IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
