//
//  CharacterDetailMockView.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty

class CharacterDetailMockView: NSObject, CharacterDetailPresenterView {
    var didStartLoadingCalled: Bool = false
    func didStartLoading() {
        self.didStartLoadingCalled = true
    }
    
    var didEndLoadingCalled: Bool = false
    func didEndLoading() {
        self.didEndLoadingCalled = true
    }
    
    var didLoadCharacterCalled: Bool = false
    func didLoadCharacter() {
        self.didLoadCharacterCalled = true
    }
    
    var renderErrorCalledWith: Error? = nil
    func renderError(error: Error) {
        self.renderErrorCalledWith = error
    }
}
