//
//  UserDataFetcher.swift
//  User Viewer
//
//  Created by Yunus Gedik on 17.01.2025.
//

import Foundation

class UserDataFetcher {
	static func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
		// Define the URL for the GET request
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
			completion(.failure(NSError(
				domain: "com.User-Viewer.network",
				code: -1,
				userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
			)))
			return
		}
		
		// Create the URLSession data task
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			// Check for errors
			if let error = error {
				completion(.failure(error))
				return
			}
			
			// Ensure valid response and data
			guard let data = data else {
				completion(.failure(NSError(
					domain: "com.User-Viewer.network",
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "No data received"]
				)))
				return
			}
			
			do {
				// Decode the JSON data into an array of User objects
				let users = try JSONDecoder().decode([User].self, from: data)
				completion(.success(users))
			} catch {
				completion(.failure(error))
			}
		}
		
		// Start the data task
		task.resume()
	}
}
