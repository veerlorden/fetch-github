//
//  RepositoryStore.swift
//  FetchTest
//
//  Created by Вадим Буркин on 12.10.2021.
//

import Foundation
import Combine

class RepositoryStore: ObservableObject {
    
    let name: String
    
    @Published var repositories: [Repository] = [] {
        didSet {
            storeInUserDefaults()
        }
    }
    
    @Published var username: String = ""
    
    private let fetcher = RepositoryFetcher()
    private var fetchRepositoriesCancellable: Set<AnyCancellable> = []
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
    }
    
    func fetchRepositories(of user: String) {
        fetcher
            .fetchData(of: user)
            .sink { repositories in
                self.repositories = repositories
            }
            .store(in: &fetchRepositoriesCancellable)
    }
    
    func clearRepositories() {
        repositories = []
        username = ""
    }
    
    private var userDefaultsKey: String {
        "RepositoryStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(repositories), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedRepositories = try? JSONDecoder().decode([Repository].self, from: jsonData) {
            repositories = decodedRepositories
        }
    }
}
