//
//  CharacterListingViewController.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import UIKit
import RickAndMortyCustomViews

class CharacterListingViewController: UIViewController, CharacterListingPresenterView {
    var presenter: CharacterListingPresenterProtocol!
    
    @IBOutlet var characterTableView: UITableView?
    
    internal var loadingView: MortyLoadingView? = nil
    internal var errorView: MortyErrorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("textCharacterListTitle", comment: "")
        self.setupTableView()
        self.presenter.viewDidLoad()
    }
    
    private func setupTableView() {
        self.characterTableView?.delegate = self
        self.characterTableView?.dataSource = self
        self.characterTableView?.register(UINib(nibName: "CharacterListingTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterListingTableViewCell")
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
    
    func didLoadCharacters(count: Int) {
        let previousCount = self.presenter.characterCount() - count
        self.characterTableView?.insertRows(at: (previousCount..<self.presenter.characterCount()).map {
            return IndexPath(row: $0, section: 0)
        }, with: .fade)
    }
    
    func renderError(error: Error) {
        MortyErrorView.show(title: "Oops!", message: error.localizedDescription)
    }
}

extension CharacterListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.characterCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListingTableViewCell", for: indexPath) as? CharacterListingTableViewCell else {
            fatalError("Invalid cell dequeue")
        }
        
        cell.reset()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let character = self.presenter.characterAt(indexPath.row) else {
            fatalError("Invalid character index")
        }
        
        (cell as? CharacterListingTableViewCell)?.setCharacter(character: character)
        
        if indexPath.row >= self.presenter.characterCount() - 4 {
            self.presenter.listDidReachBottom()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.selectedCharacterAt(indexPath.row)
    }
}
