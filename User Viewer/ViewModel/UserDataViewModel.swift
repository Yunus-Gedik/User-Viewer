//
//  UserDataViewModel.swift
//  User Viewer
//
//  Created by Yunus Gedik on 19.01.2025.
//

class UserDataViewModel {
	private var repository: UserDataRepository!
	
	init(repository: UserDataRepository!) {
		self.repository = repository
	}
	
	func fetchUserData(completion: @escaping (Result<[User], Error>) -> Void) {
		Task {
			do {
				let users = try await repository.fetchUsers()
				completion(.success(users))
			} catch {
				completion(.failure(error))
			}
		}
	}
}
