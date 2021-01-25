//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 24/01/21.
//

import UIKit
import SDWebImage
import RickAndMortyCustomViews

class CharacterDetailViewController: UIViewController, CharacterDetailPresenterView {
    var presenter: CharacterDetailPresenterProtocol!
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var statusLabel: UILabel?
    @IBOutlet var typeLabel: UILabel?
    @IBOutlet var speciesLabel: UILabel?
    @IBOutlet var genderLabel: UILabel?
    @IBOutlet var episodeCountLabel: UILabel?
    
    internal var loadingView: MortyLoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

    // MARK: - Delegate
    
    func didStartLoading() {
        self.loadingView = MortyLoadingView.fromXIB()
        self.loadingView?.show()
    }
    
    func didEndLoading() {
        self.loadingView?.dismiss()
        self.loadingView = nil
    }
    
    func didLoadCharacter() {
        guard let character = self.presenter.character else {
            fatalError("Invalid character")
        }
        
        guard let characterImage = URL(string: character.image) else {
            fatalError("Invalid character image")
        }
        
        self.imageView?.sd_cancelCurrentImageLoad()
        
        self.nameLabel?.text = character.name
        self.statusLabel?.text = character.status
        self.typeLabel?.text = character.type
        self.speciesLabel?.text = character.species
        self.genderLabel?.text = character.gender
        self.episodeCountLabel?.text = String(format: "%i episodes", character.episode.count)
        self.imageView?.sd_setImage(with: characterImage, completed: nil)
    }
    
    func renderError(error: Error) {
        MortyErrorView.show(title: "Oops!", message: error.localizedDescription)
    }
}
