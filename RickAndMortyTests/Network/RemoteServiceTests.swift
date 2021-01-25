//
//  RemoteServiceTests.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 23/01/21.
//

import Foundation
import Quick
import Nimble
@testable import RickAndMorty

class RemoteServiceTests: QuickSpec {
    
    var remoteService: RemoteService?
    
    override func spec() {
        super.spec()
        
        beforeEach {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self]
            let urlSession = URLSession(configuration: configuration)
            
            self.remoteService = RemoteService(withURLSession: urlSession)
            
            MockURLProtocol.mock = nil
        }
        
        it("fetch characters calls correct endpoint") {
            MockURLProtocol.mock = { request in
                if request.url?.absoluteString.hasPrefix("https://rickandmortyapi.com/api/character?page=") == true {
                    let testBundle = Bundle(for: type(of: self))
                    let url = testBundle.url(forResource: "character_list", withExtension: "json")!
                    let data = (try! Data(contentsOf: url))
                    let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    return (response, data)
                } else {
                    let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
                    return (response, Data([]))
                }
            }
            
            waitUntil { done in
                self.remoteService?.fetchCharacters(completionHandler: { (result) in
                    var characters: [ShowCharacter]?
                    if case .success(let _characters) = result {
                        characters = _characters
                    }
                    
                    expect(characters?.count).to(equal(20))
                    done()
                    
                })
            }
        }
        
        it("fetch single character calls correct endpoint") {
            MockURLProtocol.mock = { request in
                if request.url?.absoluteString.hasPrefix("https://rickandmortyapi.com/api/character/20") == true {
                    let testBundle = Bundle(for: type(of: self))
                    let url = testBundle.url(forResource: "single_character", withExtension: "json")!
                    let data = (try! Data(contentsOf: url))
                    let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    return (response, data)
                } else {
                    let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
                    return (response, Data([]))
                }
            }
            
            waitUntil { done in
                self.remoteService?.fetchCharacter(id: 20) { (result) in
                    var character: ShowCharacter?
                    if case .success(let _character) = result {
                        character = _character
                    }
                    
                    expect(character?.id).to(equal(2))
                    done()
                    
                }
            }
        }
        
        it("calls success with some data") {
            MockURLProtocol.mock = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, Data([ 127, 64, 32, 44, 44, 44 ]))
            }
            
            waitUntil { done in
                self.remoteService?.fetch(url: URL(string: "http://localhost:1337")!, completionHandler: { result in
                    
                    var data: Data?
                    if case .success(let _data) = result {
                        data = _data
                    }
                    
                    expect(data).toNot(beNil())
                    expect(data?.first).to(equal(127))
                    expect(data?.last).to(equal(44))
                    done()
                })
            }
        }
        
        
        it("calls invalid status code when errored") {
            MockURLProtocol.mock = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
                return (response, Data([ 127, 64, 32, 44, 44, 44 ]))
            }
            
            waitUntil { done in
                
                self.remoteService?.fetch(url: URL(string: "http://localhost:1337")!, completionHandler: { result in
                    
                    var error: Error?
                    if case .failure(let _error) = result {
                        error = _error
                    }
                    
                    expect(error).toNot(beNil())
                    expect(error?.localizedDescription).to(equal(RickAndMortyError.invalidStatusCode.localizedDescription))
                    done()
                })
                
            }
        }
        
        it("calls invalid data when receiving empty responses") {
            MockURLProtocol.mock = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, nil)
            }
            
            waitUntil { done in
                
                self.remoteService?.fetch(url: URL(string: "http://localhost/no_data")!, completionHandler: { result in
                    
                    var error: Error?
                    if case .failure(let _error) = result {
                        error = _error
                    }
                    
                    expect(error).toNot(beNil())
                    expect(error?.localizedDescription).to(equal(RickAndMortyError.invalidData.localizedDescription))
                    done()
                })
                
            }
        }
    }
}
