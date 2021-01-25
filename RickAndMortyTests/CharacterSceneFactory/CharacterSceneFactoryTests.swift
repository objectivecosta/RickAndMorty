//
//  CharacterSceneFactoryTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty
import Quick
import Nimble

class CharacterSceneFactoryTests: QuickSpec {
    override func spec() {
        super.spec()
                
        it("should create the character listing with parameters") {
            let viewController = CharacterSceneFactory.makeList() as? CharacterListingViewController

            expect {
                viewController?.presenter
            }.to(beAKindOf(CharacterListingPresenter.self))
        }
        
        it("should create the character listing with the delegate set when passed") {
            let delegate = CharacterListingMockDelegate()
            let viewController = CharacterSceneFactory.makeList(delegate: delegate) as? CharacterListingViewController

            expect {
                (viewController?.presenter as? CharacterListingPresenter)?.delegate
            }.to(beAKindOf(CharacterListingMockDelegate.self))
        }
        
        it("should create the character detail with parameters") {
            let viewController = CharacterSceneFactory.makeDetail(characterId: 0) as? CharacterDetailViewController

            expect {
                viewController?.presenter
            }.to(beAKindOf(CharacterDetailPresenter.self))
        }
        
    }
}
