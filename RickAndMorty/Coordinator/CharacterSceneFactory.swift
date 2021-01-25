//
//  NavigationFlowFactory.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import UIKit

class CharacterSceneFactory {
    static func makeList(delegate: CharacterListingPresenterDelegate? = nil) -> UIViewController {
        let viewController = CharacterListingViewController()
        let presenter = CharacterListingPresenter(withView: viewController, service: RemoteService())
        presenter.delegate = delegate
        viewController.presenter = presenter
        return viewController
    }
    
    static func makeDetail(characterId: Int) -> UIViewController {
        let viewController = CharacterDetailViewController()
        let presenter = CharacterDetailPresenter(withView: viewController, service: RemoteService(), characterId: characterId)
        viewController.presenter = presenter
        return viewController
    }
}
