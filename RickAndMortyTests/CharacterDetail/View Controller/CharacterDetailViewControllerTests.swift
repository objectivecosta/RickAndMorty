//
//  CharacterDetailViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty
import Quick
import Nimble

class CharacterDetailViewControllerTests: QuickSpec {
    
    var viewController: CharacterDetailViewController?
    var mockPresenter: CharacterDetailMockPresenter?
    var mockService: CharacterDetailMockService?
    
    override func spec() {
        super.spec()
        
        beforeEach {
            self.mockService = CharacterDetailMockService()
            self.mockPresenter = CharacterDetailMockPresenter()
            
            self.viewController = CharacterDetailViewController()
            self.viewController?.presenter = self.mockPresenter
            
            let view = UIView()
            
            self.viewController?.view.frame = CGRect(x: 0, y: 0, width: 320.0, height: 480.0)
            
            if let viewControllerView = self.viewController?.view {
                view.addSubview(viewControllerView)
            }
        }
        
        it("calls presenter's view did load") {
            expect {
                self.mockPresenter?.viewDidLoadCalled
            }.toEventually(beTruthy())
        }
        
        it("fills the labels adequately") {
            self.viewController?.didLoadCharacter()
            expect {
                self.viewController?.episodeCountLabel?.text
            }.toEventually(equal(String(format: "%i episodes", self.mockPresenter!.character!.episode.count)))
            
            expect {
                self.viewController?.genderLabel?.text
            }.toEventually(equal(self.mockPresenter!.character!.gender))
            
            expect {
                self.viewController?.genderLabel?.text
            }.toEventually(equal(self.mockPresenter!.character!.gender))
            
            expect {
                self.viewController?.nameLabel?.text
            }.toEventually(equal(self.mockPresenter!.character!.name))
            
            expect {
                self.viewController?.speciesLabel?.text
            }.toEventually(equal(self.mockPresenter!.character!.species))
            
            expect {
                self.viewController?.statusLabel?.text
            }.toEventually(equal(self.mockPresenter!.character!.status))
        }
        
        it("creates a loading view when loading starts") {
            self.viewController?.didStartLoading()
            
            expect {
                self.viewController?.loadingView
            }.toNot(beNil())
        }
        
        it("destroys a loading view when loading ends") {
            self.viewController?.loadingView = MortyLoadingView.fromXIB()
            self.viewController?.didEndLoading()
            
            expect {
                self.viewController?.loadingView
            }.to(beNil())
        }
        
        it("creates an error view when an error occurs") {
            self.viewController?.renderError(error: RickAndMortyError.invalidData)
            
            expect {
                MortyErrorView.currentErrorView
            }.toNot(beNil())
            
            MortyErrorView.currentErrorView?.dismiss()
        }
    }
}
