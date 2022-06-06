//
//  MessagesDataCource.swift
//  TestMamleev
//
//  Created by Andrey on 25.05.2022.
//

import Foundation
import UIKit

class MessagesDataSource: NSObject {
    var messages = [String]()
}

extension MessagesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageCell.reuseID(), for: indexPath
        ) as! MessageCell
        cell.setUp(message: messages[indexPath.row])
        cell.transform = CGAffineTransform(rotationAngle: (-.pi))
        return cell
    }
}
