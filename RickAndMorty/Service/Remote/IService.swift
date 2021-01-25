//
//  IService.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

protocol IService {
    func fetch(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
    func decode<T : Decodable>(data: Data, completionHandler: (Result<T, Error>) -> Void)
    func execute<T : Decodable>(_ type: T.Type, url: URL, completionHandler: @escaping (Result<T, Error>) -> Void)
}

extension IService {
    func decode<T : Decodable>(data: Data, completionHandler: (Result<T, Error>) -> Void) {
        do {
            let deserialized = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(deserialized))
        } catch {
            completionHandler(.failure(RickAndMortyError.failedToSerialize))
        }
    }
    
    func execute<T : Decodable>(_ type: T.Type, url: URL, completionHandler: @escaping (Result<T, Error>) -> Void) {
        self.fetch(url: url) { (fetchResult) in
            switch fetchResult {
            case .success(let data):
                self.decode(data: data, completionHandler: completionHandler)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
