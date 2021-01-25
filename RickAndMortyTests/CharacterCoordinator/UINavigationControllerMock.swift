//
//  UINavigationControllerMock.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 25/01/21.
//

import UIKit

class UINavigationControllerMock: UINavigationController {
    
    var lastPushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.lastPushedViewController = viewController
    }
}
