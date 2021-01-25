//
//  CharacterDetailMockPresenter.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty

class CharacterDetailMockPresenter: NSObject, CharacterDetailPresenterProtocol {
    
    var character: ShowCharacter? {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "single_character", withExtension: "json")!
        let data = (try! Data(contentsOf: url))
        return try! JSONDecoder().decode(ShowCharacter.self, from: data)
    }
    
    var viewDidLoadCalled: Bool = true
    func viewDidLoad() {
        self.viewDidLoadCalled = true
    }
    
    var fetchCharacterCalledWith: Int? = nil
    func fetchCharacter(id: Int) {
        self.fetchCharacterCalledWith = id
    }
    
    var dismissViewCalled: Bool = false
    func dismissView() {
        self.dismissViewCalled = true
    }
}
