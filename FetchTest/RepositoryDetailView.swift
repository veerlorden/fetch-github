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
        Text(repository.name)
    }
}

// MARK: - Previews

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = Repository(name: "veerlorden", id: 1)
        RepositoryDetailView(repository: repository)
    }
}
