//
//  Photo.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import Foundation

struct Photo: Decodable {
    let id: String?
    let createdAt: String?
    let width: Int?
    let height: Int?
    let urls: Urls?
    let likes: Int?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}

struct Urls: Decodable {
    let raw: String?
    let small: String?
    
    enum CodingKeys: String, CodingKey {
        case raw
        case small
    }
}

struct User: Decodable {
    let name: String?
    let profileImage: ProfileImage?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    let medium: String?
    
    enum CodingKeys: String, CodingKey {
        case medium
    }
}
