//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 24/01/21.
//

import Foundation

protocol RickAndMortyService: IService {
    func fetchCharacters(page: Int, completionHandler: @escaping (Result<[ShowCharacter], Error>) -> Void)
    func fetchCharacter(id: Int, completionHandler: @escaping (Result<ShowCharacter, Error>) -> Void)
}
