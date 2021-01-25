//
//  ResponseInfo.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

struct ResponseInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var previous: String?
}
