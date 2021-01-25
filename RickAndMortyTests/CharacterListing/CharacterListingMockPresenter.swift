//
//  CharacterListingMockPresenter.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty

class CharacterListingMockPresenter: NSObject, CharacterListingPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    func viewDidLoad() {
        self.viewDidLoadCalled = true
    }
    
    var fetchCharactersCalledWith: Int? = nil
    func fetchCharacters(page: Int) {
        fetchCharactersCalledWith = page
    }
    
    var characterCountCalled: Bool = false
    func characterCount() -> Int {
        self.characterCountCalled = true
        return 10
    }
    
    var listDidReachBottomCalled: Bool = false
    func listDidReachBottom() {
        self.listDidReachBottomCalled = true
    }
    
    var characterAtCalledWith: Int? = nil
    func characterAt(_ index: Int) -> ShowCharacter? {
        self.characterAtCalledWith = index
        
        let location = Location(name: "Elon Musk's House", url: "https://tesla.com")
        
        return ShowCharacter(id: 0, name: "Él Camarón", status: "Fried", species: "Shrimp", type: "Non-human food", gender: "Many", origin: location, location: location, image: "https://image.com/", episode: [
        "Episode Nil"], url: "http://elcamaron.gov.mars", created: "2020")
    }
    
    var selectedCharacterAtCalledWith: Int? = nil
    func selectedCharacterAt(_ index: Int) {
        self.selectedCharacterAtCalledWith = index
    }
}
