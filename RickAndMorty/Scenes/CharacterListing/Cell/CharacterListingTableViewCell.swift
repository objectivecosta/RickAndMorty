//
//  CharacterListingTableViewCell.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import UIKit
import SDWebImage

class CharacterListingTableViewCell: UITableViewCell {
    
    // Gosto de deixar os @IBOutlets como opcionais:
    // Caso não utilizemos uma view, é só remover do
    // XIB. ;D
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var statusLabel: UILabel?
    @IBOutlet var speciesLabel: UILabel?
    @IBOutlet var locationLabel: UILabel?
    
    @IBOutlet var characterImageView: UIImageView?
    
    func setCharacter(character: ShowCharacter) {
        guard let characterImage = URL(string: character.image) else {
            fatalError("Invalid character image")
        }
        
        self.nameLabel?.text = character.name
        self.locationLabel?.text = character.location.name
        self.speciesLabel?.text = character.species
        self.statusLabel?.text = character.status
        self.characterImageView?.sd_setImage(with: characterImage, completed: nil)
    }
    
    func reset() {
        self.characterImageView?.sd_cancelCurrentImageLoad()
        self.nameLabel?.text = nil
        self.statusLabel?.text = nil
        self.speciesLabel?.text = nil
        self.locationLabel?.text = nil
        self.characterImageView?.image = nil
    }
}
