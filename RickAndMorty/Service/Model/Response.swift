//
//  Response.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

class Response<T : Codable>: Codable {
    var info: ResponseInfo
    var results: T
}
