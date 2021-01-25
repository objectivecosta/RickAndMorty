//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import Foundation

class RemoteService: RickAndMortyService {
    
    var urlSession: URLSession
    
    init(withURLSession urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchCharacters(page: Int = 0, completionHandler: @escaping (Result<[ShowCharacter], Error>) -> Void) {
        guard let url = URL(string: String(format: "https://rickandmortyapi.com/api/character?page=%i", page)) else {
            fatalError("TODO: Change this.")
        }
        
        self.execute(Response<[ShowCharacter]>.self, url: url) { (result) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchCharacter(id: Int, completionHandler: @escaping (Result<ShowCharacter, Error>) -> Void) {
        guard let url = URL(string: String(format: "https://rickandmortyapi.com/api/character/%i", id)) else {
            fatalError("TODO: Change this.")
        }
        
        self.execute(ShowCharacter.self, url: url) { (result) in
            switch result {
            case .success(let character):
                completionHandler(.success(character))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetch(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(.failure(error!))
                    return
                }
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completionHandler(.failure(RickAndMortyError.invalidStatusCode))
                    return
                }
                
                guard let data = data, !data.isEmpty else {
                    completionHandler(.failure(RickAndMortyError.invalidData))
                    return
                }
                
                completionHandler(.success(data))
            }
            
        }
        
        dataTask.resume()
    }
}
