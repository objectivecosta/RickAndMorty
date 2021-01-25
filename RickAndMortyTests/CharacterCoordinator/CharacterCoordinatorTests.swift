//
//  CharacterCoordinatorTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 25/01/21.
//

import Foundation
import Quick
import Nimble
@testable import RickAndMorty

class CharacterCoordinatorTests: QuickSpec {
    
    var coordinator: CharacterCoordinator?
    var navigationControllerMock: UINavigationControllerMock?
    
    override func spec() {
        super.spec()
        
        beforeEach {
            self.navigationControllerMock = UINavigationControllerMock()
            self.coordinator = CharacterCoordinator(withNavigationController: self.navigationControllerMock!)
        }
        
        it("calls set view controllers on start") {
            self.coordinator?.showRoot()
            expect {
                self.navigationControllerMock?.viewControllers.count
            }.to(equal(1))
            
            expect {
                self.navigationControllerMock?.viewControllers.first
            }.to(beAKindOf(CharacterListingViewController.self))
        }
        
        it("calls push on navigate to detail on start") {
            self.coordinator?.showDetail(characterId: 2)
            
            expect {
                self.navigationControllerMock?.lastPushedViewController
            }.to(beAKindOf(CharacterDetailViewController.self))
        }
        
        it("calls push on listing delegate call") {
            self.coordinator?.characterListingPresenter(CharacterListingMockPresenter(), didSelectCharacterWithId: 2)
            
            let viewController: CharacterDetailViewController? = (self.navigationControllerMock?.lastPushedViewController as? CharacterDetailViewController)
            let presenter: CharacterDetailPresenter? = (viewController?.presenter as? CharacterDetailPresenter)
            
            expect {
                presenter?.characterId
            }.to(equal(2))
            
        }
        
        it("calls pop on detail delegate call") {
            self.coordinator?.characterDetailPresenterDidRequestDismissal(CharacterDetailMockPresenter())

            expect {
                self.navigationControllerMock?.popViewControllerCalledWith
            }.toNot(beNil())
            
            expect {
                self.navigationControllerMock?.popViewControllerCalledWith
            }.to(equal(true))
            
        }
        
        it("calls pop on pop call") {
            self.coordinator?.pop()

            expect {
                self.navigationControllerMock?.popViewControllerCalledWith
            }.toNot(beNil())
            
            expect {
                self.navigationControllerMock?.popViewControllerCalledWith
            }.to(equal(true))   
        }
    }
}
