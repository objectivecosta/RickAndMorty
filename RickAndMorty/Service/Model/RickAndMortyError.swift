//
//  RickAndMortyError.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

enum RickAndMortyError: Error, LocalizedError, Equatable {
    case invalidStatusCode
    case invalidData
    case failedToSerialize
    
    var errorDescription: String? {
        switch self {
        case .invalidStatusCode:
            return NSLocalizedString("errorInvalidStatusCodeDescription", comment: "")
        case .invalidData:
            return NSLocalizedString("errorInvalidDataDescription", comment: "")
        case .failedToSerialize:
            return NSLocalizedString("errorFailedToSerializeDescription", comment: "")
        default:
            return NSLocalizedString("errorUnknownDescription", comment: "")
        }
    }
}
