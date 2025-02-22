//
//  UserDataRepository.swift
//  User Viewer
//
//  Created by Yunus Gedik on 18.01.2025.
//

protocol UserDataRepository {
	func fetchUsers() async throws -> [User]
}
