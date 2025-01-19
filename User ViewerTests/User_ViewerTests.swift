//
//  User_ViewerTests.swift
//  User ViewerTests
//
//  Created by Yunus Gedik on 16.01.2025.
//

import XCTest
@testable import User_Viewer

final class UserDataViewModelTests: XCTestCase {
	
	func testFetchUserDataSuccess() async {
		let expectedUsers = getMockUserData()

		let mockRepository = MockUserDataRepository(shouldThrowError: false, mockUsers: expectedUsers)

		let viewModel = UserDataViewModel(repository: mockRepository)
		
		// Wait for completion handler to complete
		let result: Result<[User], Error> = await withCheckedContinuation { continuation in
			viewModel.fetchUserData { result in
				continuation.resume(returning: result)
			}
		}

		// Act upon result
		switch result {
		case .success(let users):
			XCTAssertEqual(users, expectedUsers, "Fetched users should match the mock users")
		case .failure:
			XCTFail("Expected success but got failure")
		}
	}
	
	func testFetchUserDataFailure() async {
		let mockRepository = MockUserDataRepository(shouldThrowError: true)
		
		let viewModel = UserDataViewModel(repository: mockRepository)

		// Wait for completion handler to complete
		let result: Result<[User], Error> = await withCheckedContinuation { continuation in
			viewModel.fetchUserData { result in
				continuation.resume(returning: result)
			}
		}
		
		// Act upon result
		switch result {
		case .success:
			XCTFail("Expected failure but got success")
		case .failure(let error):
			XCTAssertTrue(
				error is URLError || error is DecodingError,
				"Expected URL or Decoding Error but got \(error)"
			)
		}
	}

	private func getMockUserData() -> [User] {
		return [
			User(
				id: 1,
				name: "Leanne Graham",
				username: "Bret",
				email: "Sincere@april.biz",
				address: Address(
					street: "Kulas Light",
					suite: "Apt. 556",
					city: "Gwenborough",
					zipcode: "92998-3874",
					geo: Geo(
						lat: "-37.3159",
						lng: "81.1496"
					)
				),
				phone: "1-770-736-8031 x56442",
				website: "hildegard.org",
				company: Company(
					name: "Romaguera-Crona",
					catchPhrase: "Multi-layered client-server neural-net",
					bs: "harness real-time e-markets"
				)
			),
			User(
				id: 2,
				name: "Erwin Howell",
				username: "Antonette",
				email: "Shanna@melissa.tv",
				address: Address(
					street: "Victor Plains",
					suite: "Suite 879",
					city: "Wisokyburgh",
					zipcode: "90566-7771",
					geo: Geo(
						lat: "-43.9509",
						lng: "-34.4618"
					)
				),
				phone: "010-692-6593 x09125",
				website: "anastasia.net",
				company: Company(
					name: "Deckow-Crist",
					catchPhrase: "Proactive didactic contingency",
					bs: "synergize scalable supply-chains"
				)
			)
		]
	}
	
}
