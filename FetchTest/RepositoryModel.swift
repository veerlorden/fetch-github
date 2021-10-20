//
//  RepositoryModel.swift
//  FetchTest
//
//  Created by Вадим Буркин on 12.10.2021.
//

import Foundation
import UIKit

struct Repository: Identifiable, Codable {
    let name: String
    let id: Int
    let createdAt: String
    let numberOfStars: Int
    let url: String
    let owner: Owner
    var language: String? = ""
    var description: String? = ""

    enum CodingKeys: String, CodingKey {
        case id, name, description, language, owner
        case createdAt = "created_at"
        case numberOfStars = "stargazers_count"
        case url = "html_url"
    }
}

struct Owner: Codable {
    let name: String
    let profileImageURL: String?

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case profileImageURL = "avatar_url"
    }
}
