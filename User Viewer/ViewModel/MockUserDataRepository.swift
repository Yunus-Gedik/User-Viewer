//
//  MockRepository.swift
//  User Viewer
//
//  Created by Yunus Gedik on 19.01.2025.
//

import Foundation

class MockUserDataRepository : UserDataRepository {
	var shouldThrowError : Bool
	var mockUsers: [User]
	
	init(shouldThrowError: Bool = false, mockUsers: [User] = []) {
		self.shouldThrowError = shouldThrowError
		self.mockUsers = mockUsers
	}
	
	func fetchUsers() async throws -> [User] {
		if shouldThrowError {
			// Actual concrete repository class may throw URL or Decoding error.
			throw URLError(.badURL)
		}
		return mockUsers
	}
}
