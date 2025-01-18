//
//  UserCell.swift
//  User Viewer
//
//  Created by Yunus Gedik on 17.01.2025.
//

import UIKit

class UserCell: UITableViewCell {

	@IBOutlet var wrapperView: UIView!

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var emailLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
    }
}
