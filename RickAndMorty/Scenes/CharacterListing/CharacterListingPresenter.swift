//
//  CharacterListingPresenter.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

// View(Controller) -> Presenter
protocol CharacterListingPresenterProtocol: NSObjectProtocol {
    func viewDidLoad()
    func listDidReachBottom()
    func fetchCharacters(page: Int)
    
    func characterCount() -> Int
    func characterAt(_ index: Int) -> ShowCharacter?
    func selectedCharacterAt(_ index: Int)
}

// Presenter -> View(Controller)
protocol CharacterListingPresenterView: NSObjectProtocol {
    func didStartLoading()
    func didEndLoading()
    func didLoadCharacters(count: Int)
    func renderError(error: Error)
}

protocol CharacterListingPresenterDelegate: NSObjectProtocol {
    func characterListingPresenter(_ characterListingPresenter: CharacterListingPresenterProtocol, didSelectCharacterWithId id: Int)
}

class CharacterListingPresenter: NSObject, CharacterListingPresenterProtocol {
    weak var view: CharacterListingPresenterView?
    weak var delegate: CharacterListingPresenterDelegate?
    
    var service: RickAndMortyService
    
    init(withView view: CharacterListingPresenterView, service: RickAndMortyService) {
        self.view = view
        self.service = service
    }
    
    private var characters: [ShowCharacter] = []
    private var page: Int? = nil
    private var isLoading: Bool = false
    
    func viewDidLoad() {
        self.fetchCharacters()
    }
    
    func listDidReachBottom() {
        guard let currentPage = self.page else {
            return
        }
        
        self.fetchCharacters(page: currentPage + 1)
    }
    
    func fetchCharacters(page: Int = 1) {
        guard self.isLoading == false else {
            return
        }
        
        self.isLoading = true
        self.view?.didStartLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.service.fetchCharacters(page: page) { (result) in
                self.isLoading = false
                self.view?.didEndLoading()
            
                switch result {
                case .success(let characters):
                    self.characters.append(contentsOf: characters)
                    self.page = page
                    self.view?.didLoadCharacters(count: characters.count)
                case .failure(let error):
                    self.view?.renderError(error: error)
                }
            }
        }
    }
    
    func characterCount() -> Int {
        return self.characters.count
    }
    
    func characterAt(_ index: Int) -> ShowCharacter? {
        return self.characters[index]
    }
    
    func selectedCharacterAt(_ index: Int) {
        guard let character = self.characterAt(index) else {
            fatalError("Invalid index")
        }
        self.delegate?.characterListingPresenter(self, didSelectCharacterWithId: character.id)
    }
}
