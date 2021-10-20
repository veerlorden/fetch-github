//
//  RepositoryDetailView.swift
//  FetchTest
//
//  Created by Вадим Буркин on 12.10.2021.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    
    var body: some View {
        VStack {
            Text(repository.name)
            Text(repository.description ?? "")
            Text(repository.language ?? "")
        }
    }
}

// MARK: - Previews

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let owner = Owner(name: "veerlorden", profileImageURL: "https://avatars.githubusercontent.com/u/63232549?v=4")
        let repository = Repository(name: "preview", id: 1, createdAt: "2021-09-30T11:16:50Z", numberOfStars: 0, url: "https://github.com/veerlorden/veerlorden", owner: owner)
        RepositoryDetailView(repository: repository)
    }
}
