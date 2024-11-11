//
//  FetchRecipesTests.swift
//  FetchRecipesTests
//
//  Created by Gaurav Bhambhani on 11/11/24.
//

import XCTest
import Combine
@testable import FetchRecipes

final class FetchRecipesTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: config)
        networkManager = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        // This method is called after the invocation of each test method in the class.
        
        networkManager = nil
        MockURLProtocol.responseData = nil
        MockURLProtocol.responseError = nil
        
        cancellables.removeAll()
        super.tearDown()
    }

    func testRecipeSuccess() throws {
        let json = """
        {
            "recipes": [
                { 
                  "cuisine": "British",
                  "name": "Chelsea Buns",
                  "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/4aecd46e-e419-49ec-8888-246b3cc0cc94/large.jpg",
                  "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/4aecd46e-e419-49ec-8888-246b3cc0cc94/small.jpg",
                  "source_url": "https://www.bbc.co.uk/food/recipes/chelsea_buns_95015",
                  "uuid": "7fc217a9-5566-4bf1-b1ce-13bc9e3f2b1a",
                  "youtube_url": "https://www.youtube.com/watch?v=i_zemP3yBKw"
                }
            ]
        }
        
        """.data(using: .utf8)!
        MockURLProtocol.responseData = json
        
        let expectation = XCTestExpectation(description: "Recipe Fetched Successfully!")
        
        // When
        networkManager.fetchRecipes()
        
        networkManager.$recipes
            .dropFirst()
            .sink { recipes in
                // Then
                XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty on success")
                XCTAssertNil(self.networkManager.errorMessage, "Error message should be nil on success")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRecipeEmpty() throws {
        let json = """
        {
            "recipes": []
        }
        
        """.data(using: .utf8)!
        MockURLProtocol.responseData = json
        
        let expectation = XCTestExpectation(description: "Empty data handled correctly")
        
        // When
        networkManager.fetchRecipes()
        
        networkManager.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Then
                XCTAssertEqual(errorMessage, "We're continuously fetching more recipes. Stay tuned!", "should show appropriate message for empty data")
                
                XCTAssertTrue(self.networkManager.recipes.isEmpty, "Recipes should be empty for empty data")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchRecipesMalformedData() throws {
            let malformedJson = """
            { "invalid_key": "Invalid data" }
            """.data(using: .utf8)!
            MockURLProtocol.responseData = malformedJson

            let expectation = XCTestExpectation(description: "Malformed data handled correctly")

            // When
            networkManager.fetchRecipes()
            
            networkManager.$errorMessage
                .dropFirst()
                .sink { errorMessage in
                    // Then
                    XCTAssertEqual(errorMessage, "Failed to decode recipes", "Should show 'Failed to decode recipes' message")
                    
                    XCTAssertTrue(self.networkManager.recipes.isEmpty, "Recipes should be empty for malformed data")
                    expectation.fulfill()
                }
                .store(in: &cancellables)

            wait(for: [expectation], timeout: 5.0)
        }
}
