//
//  MessageCell.swift
//  Chat Bee
//
//  Created by Yashrajsinh
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageBobble: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBobble.layer.cornerRadius = messageBobble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
