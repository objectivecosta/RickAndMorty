//
//  CharacterListingPresenterTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation
import Quick
import Nimble
@testable import RickAndMorty

class CharacterListingPresenterTests: QuickSpec {
    
    var presenter: CharacterListingPresenter?
    var mockView: CharacterListingMockView?
    var mockService: CharacterListingMockService?
    var mockDelegate: CharacterListingMockDelegate?
    
    override func spec() {
        
        super.spec()
        
        beforeEach {
            Nimble.AsyncDefaults.timeout = .seconds(8)

            self.mockView  = CharacterListingMockView()
            self.mockService = CharacterListingMockService()
            self.mockDelegate = CharacterListingMockDelegate()
            
            self.presenter = CharacterListingPresenter(withView: self.mockView!, service: self.mockService!)
            self.presenter?.delegate = self.mockDelegate
        }
        
        it("calls did load when data was fetched") {
            self.presenter?.viewDidLoad()
            expect({
                self.mockView?.didLoadCharactersCalledWith
            }).toEventually(equal(20))
        }
        
        it("calls render error on failure") {
            self.mockService?.replyWithError = .errorResponse
            self.presenter?.viewDidLoad()
            expect {
                self.mockView?.renderErrorCalledWith
            }.toEventuallyNot(beNil())
        }
        
        it("calls correct render error on invalid json") {
            self.mockService?.replyWithError = .invalidJson
            self.presenter?.viewDidLoad()
            expect {
                self.mockView?.renderErrorCalledWith?.localizedDescription
            }.toEventually(equal(RickAndMortyError.failedToSerialize.localizedDescription))
        }
        
        it("calls correct render error on invalid status code") {
            self.mockService?.replyWithError = .invalidStatusCode
            self.presenter?.viewDidLoad()
            expect {
                self.mockView?.renderErrorCalledWith?.localizedDescription
            }.toEventually(equal(RickAndMortyError.invalidStatusCode.localizedDescription))
        }
        
        it("calls correct render error on invalid data") {
            self.mockService?.replyWithError = .invalidData
            self.presenter?.viewDidLoad()
            expect {
                self.mockView?.renderErrorCalledWith?.localizedDescription
            }.toEventually(equal(RickAndMortyError.invalidData.localizedDescription))
        }
        
        it("calls didStart/didEnd loading") {
            self.mockService?.replyWithError = nil
            self.presenter?.viewDidLoad()
            expect {
                self.mockView?.didStartLoadingCalled
            }.toEventually(beTruthy())
            
            expect {
                self.mockView?.didEndLoadingCalled
            }.toEventually(beTruthy())
        }
        
        it("stores chacacters correctly") {
            self.mockService?.replyWithError = nil
            self.presenter?.viewDidLoad()
            expect {
                self.mockView?.didLoadCharactersCalledWith
            }.toEventually(equal(20))
            
            expect {
                self.presenter?.characterCount()
            }.toEventually(equal(20))
            
            expect {
                self.presenter?.characterAt(0)?.id
            }.toEventually(equal(1))
        }
        
        it("calls delegate on selection with the correct character id") {
            self.mockService?.replyWithError = nil
            self.presenter?.viewDidLoad()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.presenter?.selectedCharacterAt(10)
            }
            
            expect {
                self.mockDelegate?.didSelectCharacterWithIdCalledWith
            }.toEventually(equal(11))
        }
        
        
    }
}
