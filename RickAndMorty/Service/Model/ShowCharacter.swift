//
//  ShowCharacter.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

// MARK: - Character
struct ShowCharacter: Codable {
    let id: Int
    let name, status, species, type, gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

