//
//  CharacterListingViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation
import XCTest
import Quick
import Nimble
@testable import RickAndMorty

class CharacterListingViewControllerTests: QuickSpec {
    
    var viewController: CharacterListingViewController?
    var mockPresenter: CharacterListingMockPresenter?
    var mockService: CharacterListingMockService?
    
    override func spec() {
        super.spec()
        
        beforeEach {
            self.mockService = CharacterListingMockService()
            self.mockPresenter = CharacterListingMockPresenter()
            
            self.viewController = CharacterListingViewController()
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
        
        it("calls character count when load is done") {
            self.viewController?.didLoadCharacters(count: 1)
            expect {
                self.mockPresenter?.characterCountCalled
            }.toEventually(beTruthy())
        }
        
        // N.B.: I prefer filling UITableViewCells just when they're gonna be shown.
        it("DOES NOT call character at when cellForRow is called") {
            _ = self.viewController?.tableView(self.viewController!.characterTableView!, cellForRowAt: IndexPath(row: 0, section: 0))
            expect {
                self.mockPresenter?.characterAtCalledWith
            }.toEventually(beNil())
        }
        
        it("DOES call character at when willDisplayCellAt is called") {
            let cell = self.viewController!.tableView(self.viewController!.characterTableView!, cellForRowAt: IndexPath(row: 0, section: 0))
            self.viewController?.tableView(self.viewController!.characterTableView!, willDisplay: cell, forRowAt: IndexPath(row: 0, section: 0))
            expect {
                self.mockPresenter?.characterAtCalledWith
            }.toEventuallyNot(beNil())
        }
        
        it("DOES NOT call character at above maximum index") {
            let cell = self.viewController!.tableView(self.viewController!.characterTableView!, cellForRowAt: IndexPath(row: 0, section: 0))
            self.viewController?.tableView(self.viewController!.characterTableView!, willDisplay: cell, forRowAt: IndexPath(row: 0, section: 0))
            
            expect {
                self.mockPresenter?.characterAtCalledWith
            }.toEventuallyNot(beGreaterThan(9))
        }
        
        it("calls presenter's did select when select happens") {
            self.viewController?.tableView(self.viewController!.characterTableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            expect {
                self.mockPresenter?.selectedCharacterAtCalledWith
            }.toEventually(equal(0))
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
