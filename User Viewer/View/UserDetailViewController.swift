//
//  UserDetailViewController.swift
//  User Viewer
//
//  Created by Yunus Gedik on 16.01.2025.
//

import UIKit

class UserDetailViewController: UIViewController {

	// Input
	var user: User? {
		didSet {
			guard let user else { return }
			
			self.title = user.name

			userData[0].value = user.name
			userData[1].value = user.email
			userData[2].value = user.phone
			userData[3].value = user.website
		}
	}
	
	var userData : [UserDetailDataModel] = [
		UserDetailDataModel(iconName: "person", title: "Name", value: ""),
		UserDetailDataModel(iconName: "envelope", title: "Email", value: ""),
		UserDetailDataModel(iconName: "phone", title: "Phone", value: ""),
		UserDetailDataModel(iconName: "link.circle", title: "Website", value: "")
	]
	
	@IBOutlet var tableView: UITableView!
	@IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initTableView()
	}
	
	private func initTableView(){
		tableView.dataSource = self
		tableView.register(UINib(nibName: "UserDetailCell", bundle: nil), forCellReuseIdentifier: "UserDetailCell")
		
		tableView.layer.cornerRadius = 20.0
		
		self.tableView.reloadData()
		
		// To ensure layout is calculated before assigning a height
		self.tableView.layoutIfNeeded()
		
		self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
		self.tableView.isHidden = false
	}
	
}

extension UserDetailViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		userData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell", for: indexPath) as! UserDetailCell
		
		cell.iconImage.image = UIImage(systemName: userData[indexPath.row].iconName)
		cell.titleLabel.text = userData[indexPath.row].title
		cell.valueLabel.text = userData[indexPath.row].value
		
		return cell
	}
}
