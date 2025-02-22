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
	
	private func setUserData(){
		let userDataViewModel = UserDataViewModel(repository: UserDataFetcher())
		
		userDataViewModel.fetchUserData { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let users):
				self.userList = users
				
				// Tableview should be update on main thread
				DispatchQueue.main.async {
					self.tableView.reloadData()
					
					// To ensure layout is calculated before assigning a height
					self.tableView.layoutIfNeeded()
					
					// Make the tableview occupy only as much space as its content
					self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
					
					// Make tableview visible when it is ready to show
					self.tableView.isHidden = false
				}
			case .failure(let error):
				print("Error fetching users: \(error)")
			}
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "goToUserDetail") {
			guard let indexPath = tableView.indexPathForSelectedRow else { return }

			// To create a bounce like effect on table view cell click
			tableView.deselectRow(at: indexPath, animated: true)

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
