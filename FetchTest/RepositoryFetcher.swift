//
//  RepositoryFetcher.swift
//  FetchTest
//
//  Created by Вадим Буркин on 12.10.2021.
//

import Foundation
import Combine

class RepositoryFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(of user: String) -> AnyPublisher<[Repository], Never> {
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else {
            return Just([Repository]()).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
