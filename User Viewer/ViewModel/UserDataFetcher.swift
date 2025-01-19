//
//  UserDataFetcher.swift
//  User Viewer
//
//  Created by Yunus Gedik on 17.01.2025.
//

import Foundation

class UserDataFetcher: UserDataRepository {
	func fetchUsers() async throws -> [User] {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
			throw URLError(.badURL)
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			return try JSONDecoder().decode([User].self, from: data)
		} catch {
			throw error
		}
	}
}
