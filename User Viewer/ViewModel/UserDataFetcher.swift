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
		
		let data: Data
		
		// Try to fetch the data
		do {
			(data, _) = try await URLSession.shared.data(from: url)
		} catch let error as URLError {
			throw error
		}
		
		// Try to decode the data
		do {
			return try JSONDecoder().decode([User].self, from: data)
		} catch let error as DecodingError {
			throw error
		}
	}
}
