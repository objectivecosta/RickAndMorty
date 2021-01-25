//
//  CharacterCoordinator.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 24/01/21.
//

import UIKit

class CharacterCoordinator: NSObject {
    let navigationController: UINavigationController
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showRoot() {
        let characterListing = CharacterSceneFactory.makeList(delegate: self)
        self.navigationController.viewControllers = [characterListing]
    }
    
    func showDetail(characterId: Int) {
        let characterDetail = CharacterSceneFactory.makeDetail(characterId: characterId)
        self.navigationController.pushViewController(characterDetail, animated: true)
    }
}

extension CharacterCoordinator: CharacterListingPresenterDelegate
{
    func characterListingPresenter(_ characterListingPresenter: CharacterListingPresenterProtocol, didSelectCharacterWithId id: Int) {
        self.showDetail(characterId: id)
    }
}
