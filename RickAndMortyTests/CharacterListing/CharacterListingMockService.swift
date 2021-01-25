//
//  CharacterListingMockService.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation
import XCTest
@testable import RickAndMorty

class CharacterListingMockService: RickAndMortyService {
    enum FailureCase {
        case errorResponse
        case invalidData
        case invalidJson
        case invalidStatusCode
    }
    
    var replyWithError: FailureCase? = nil
    
    func fetchCharacters(page: Int, completionHandler: @escaping (Result<[ShowCharacter], Error>) -> Void) {
        self.execute(Response<[ShowCharacter]>.self, url: URL(string: "http://character_list")!) { (result) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchCharacter(id: Int, completionHandler: @escaping (Result<ShowCharacter, Error>) -> Void) {
        fatalError()
    }
    
    func fetch(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        switch self.replyWithError {
        case .none:
            
            let testBundle = Bundle(for: type(of: self))
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                let url = testBundle.url(forResource: url.host!, withExtension: "json")!
                let data = try! Data(contentsOf: url)
                completionHandler(.success(data))
            }
            
        case .errorResponse:

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                let error = NSError(domain: NSURLErrorDomain, code: -1009, userInfo: [
                    NSLocalizedDescriptionKey : "The Internet connection appears to be offline."
                ])
                completionHandler(.failure(error))
            }
        
        case .invalidJson:
            
            let testBundle = Bundle(for: type(of: self))
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                let url = testBundle.url(forResource: url.host!, withExtension: "json")!
                let data = "{{{{{{=====".data(using: .utf8)! + (try! Data(contentsOf: url))
                completionHandler(.success(data))
            }
            
        case .invalidStatusCode:
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler(.failure(RickAndMortyError.invalidStatusCode))
            }
            
        case .invalidData:
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler(.failure(RickAndMortyError.invalidData))
            }
            
        }
        
    }
}
