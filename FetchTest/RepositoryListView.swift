//
//  RepositoryListView.swift
//  FetchTest
//
//  Created by Вадим Буркин on 12.10.2021.
//

import SwiftUI

struct RepositoryListView: View {
    
    @ObservedObject var store: RepositoryStore
    
    var body: some View {
        NavigationView {
            List {
                searchField
                repositoriesList
            }
            .listStyle(.grouped)
            .navigationTitle("Github Repositories")
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Clear") {
                        store.clearRepositories()
                    }
                    .disabled(store.repositories.isEmpty)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    var searchField: some View {
        Section {
            HStack {
                if #available(iOS 15.0, *) {
                    TextField("e.g. veerlorden", text: $store.username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                } else {
                    TextField("e.g. veerlorden", text: $store.username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Button("Get") {
                    store.fetchRepositories(of: store.username)
                }
            }
        }
    }
    
    var repositoriesList: some View {
        Section {
            ForEach(store.repositories) { repository in
                NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                    Text(repository.name)
                }
            }
        } header: {
            !store.repositories.isEmpty ? Text("Repositories List") : Text("")
        }
    }
}

// MARK: - Previews

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let store = RepositoryStore(named: "Preview")
        RepositoryListView(store: store)
    }
}
