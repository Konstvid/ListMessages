//
//  CellTableViewCell.swift
//  TestMamleev
//
//  Created by Andrey on 25.05.2022.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet private weak var messageLabel: UILabel!
    
    func setUp(message: String) {
        messageLabel.text = message
    }
    
    class func reuseID() -> String {
        NSStringFromClass(MessageCell.self).components(separatedBy: ".").last!
    }
}
