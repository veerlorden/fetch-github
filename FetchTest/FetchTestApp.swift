//
//  FetchTestApp.swift
//  FetchTest
//
//  Created by Вадим Буркин on 12.10.2021.
//

import SwiftUI

@main
struct FetchTestApp: App {
    @StateObject var store = RepositoryStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            RepositoryListView(store: store)
        }
    }
}
