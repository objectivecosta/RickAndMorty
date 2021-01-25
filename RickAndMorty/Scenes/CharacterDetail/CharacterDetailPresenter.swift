//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation

// View(Controller) -> Presenter
protocol CharacterDetailPresenterProtocol: NSObjectProtocol {
    func viewDidLoad()
    func fetchCharacter(id: Int)
    
    func dismissView()
    
    var character: ShowCharacter? { get }
}

// Presenter -> View(Controller)
protocol CharacterDetailPresenterView: NSObjectProtocol {
    func didStartLoading()
    func didEndLoading()
    func didLoadCharacter()
    func renderError(error: Error)
}

protocol CharacterDetailPresenterDelegate: NSObjectProtocol {
    func characterDetailPresenterDidRequestDismissal(_ characterDetailPresenter: CharacterDetailPresenterProtocol)
}

class CharacterDetailPresenter: NSObject, CharacterDetailPresenterProtocol {
    weak var view: CharacterDetailPresenterView?
    weak var delegate: CharacterDetailPresenterDelegate?
    var service: RickAndMortyService
    var characterId: Int
    
    init(withView view: CharacterDetailPresenterView, service: RickAndMortyService, characterId: Int) {
        self.view = view
        self.service = service
        self.characterId = characterId
    }
    
    var character: ShowCharacter?
    private var isLoading: Bool = false
    
    func viewDidLoad() {
        self.fetchCharacter(id: self.characterId)
    }

    func fetchCharacter(id: Int) {
        guard self.isLoading == false else {
            return
        }
        
        self.isLoading = true
        self.view?.didStartLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.service.fetchCharacter(id: id) { (result) in
                self.isLoading = false
                self.view?.didEndLoading()
                
                switch result {
                case .success(let character):
                    self.character = character
                    self.view?.didLoadCharacter()
                case .failure(let error):
                    self.view?.renderError(error: error)
                }
            }
        }
    }
    
    func dismissView() {
        self.delegate?.characterDetailPresenterDidRequestDismissal(self)
    }

}
