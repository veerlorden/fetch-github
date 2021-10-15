//
//  FetchTestTests.swift
//  FetchTestTests
//
//  Created by Вадим Буркин on 13.10.2021.
//

import XCTest
import Combine
@testable import FetchTest

class FetchTestTests: XCTestCase {
    private var store: RepositoryStore!
    private var fetcher: RepositoryFetcher!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        store = RepositoryStore(named: "Testing")
        fetcher = RepositoryFetcher()
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        store = nil
        fetcher = nil
    }
    
    func testIfClearButtonRemovesTextAndRepos() {
        store.repositories.append(Repository(name: "test", id: 1))
        store.clearRepositories()
        
        XCTAssertTrue(store.repositories.isEmpty)
        XCTAssertEqual(store.username, "")
    }
    
    func testFetchingCorrectRepositoryName() {
        let username = "veerlorden"
        let expectation = expectation(description: "Fetched some data")
        var repositories: [Repository] = []
        
        fetcher
            .fetchData(of: username)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { value in
                repositories = value
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual("countdown-timer", repositories[0].name)
    }
}
