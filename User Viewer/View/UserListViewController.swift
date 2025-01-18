//
//  ViewController.swift
//  User Viewer
//
//  Created by Yunus Gedik on 16.01.2025.
//

import UIKit

class UserListViewController: UIViewController {
	
	@IBOutlet var tableView: UITableView!
	@IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
	
	var userList: [User]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initTableView()
		setUserData()
	}
	
	private func initTableView(){
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
		
		tableView.layer.cornerRadius = 20.0
	}
	
	private func setUserData(userDataFetcher: UserDataRepository = UserDataFetcher()){
		userDataFetcher.fetchUsers { result in
			switch result {
			case .success(let users):
				self.userList = users + users
				DispatchQueue.main.async {
					self.tableView.reloadData()
					self.tableView.layoutIfNeeded()
					self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
					self.tableView.isHidden = false
				}
			case .failure(let error):
				print("Error fetching users: \(error)")
			}
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToUserDetail" {
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			let userDetailVC = segue.destination as! UserDetailViewController
			userDetailVC.user = userList![indexPath.row]
		}
	}
	
}

extension UserListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToUserDetail", sender: self)
	}
}

extension UserListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		userList?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
		
		guard let userList else { return cell }
		
		cell.nameLabel.text = userList[indexPath.row].name
		cell.emailLabel.text = userList[indexPath.row].email
		
		return cell
	}
}
