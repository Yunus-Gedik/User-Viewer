//
//  UserDetailCell.swift
//  User Viewer
//
//  Created by Yunus Gedik on 18.01.2025.
//

import UIKit

class UserDetailCell: UITableViewCell {

	@IBOutlet var iconImage: UIImageView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var valueLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
}
