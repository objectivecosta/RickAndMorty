//
//  CharacterListingMockDelegate.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty


class CharacterListingMockView: NSObject, CharacterListingPresenterView {
    var didStartLoadingCalled: Bool = false
    func didStartLoading() {
        self.didStartLoadingCalled = true
    }
    
    var didEndLoadingCalled: Bool = false
    func didEndLoading() {
        self.didEndLoadingCalled = true
    }
    
    var didLoadCharactersCalledWith: Int? = nil
    func didLoadCharacters(count: Int) {
        self.didLoadCharactersCalledWith = count
    }
    
    var renderErrorCalledWith: Error? = nil
    func renderError(error: Error) {
        self.renderErrorCalledWith = error
    }
}
