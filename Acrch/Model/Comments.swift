//
//  Comments.swift
//  Acrch
//
//  Created by Evhen Lukhtan on 21.02.2023.
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
import Foundation

struct Comments: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

