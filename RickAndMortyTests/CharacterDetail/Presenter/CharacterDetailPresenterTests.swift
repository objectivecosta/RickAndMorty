//
//  CharacterDetailPresenterTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty
import Nimble
import Quick

class CharacterDetailPresenterTests: QuickSpec {
    var presenter: CharacterDetailPresenterProtocol?
    var mockView: CharacterDetailMockView?
    var mockService: CharacterDetailMockService?
    
    override func spec() {
        
        super.spec()
        
        beforeEach {
            Nimble.AsyncDefaults.timeout = .seconds(8)

            self.mockView  = CharacterDetailMockView()
            self.mockService = CharacterDetailMockService()
            
            self.presenter = CharacterDetailPresenter(withView: self.mockView!, service: self.mockService!, characterId: 2)
        }
        
        it("calls did load when data was fetched") {
            self.presenter?.viewDidLoad()
            expect({
                self.mockView?.didLoadCharacterCalled
            }).toEventually(beTruthy())
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
                self.presenter?.character?.id
            }.toEventually(equal(2))
        }
    }
}
