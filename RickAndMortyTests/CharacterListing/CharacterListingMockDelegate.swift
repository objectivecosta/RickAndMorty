//
//  CharacterListingMockDelegate.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation
@testable import RickAndMorty

class CharacterListingMockDelegate: NSObject, CharacterListingPresenterDelegate {
    var didSelectCharacterWithIdCalledWith: Int? = nil
    func characterListingPresenter(_ characterListingPresenter: CharacterListingPresenterProtocol, didSelectCharacterWithId id: Int) {
        self.didSelectCharacterWithIdCalledWith = id
    }
}
