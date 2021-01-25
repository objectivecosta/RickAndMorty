//
//  MortyError.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 22/01/21.
//

import UIKit
import Lottie

public class MortyErrorView: UIView {
    
    internal static var currentErrorView: MortyErrorView? = nil
    
    static func fromXIB() -> MortyErrorView {
        let views = UINib(nibName: "MortyErrorView", bundle: nil).instantiate(withOwner: nil, options: nil)
        
        guard let mortyErrorView = views.first as? MortyErrorView else {
            fatalError("Failure to decode XIB")
        }
        
        return mortyErrorView
    }
    
    public static func show(title: String, message: String) {
        self.currentErrorView?.dismiss()
        
        let view = MortyErrorView.fromXIB()
        self.currentErrorView = view
        
        guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else {
            return
        }
        
        window.addSubview(view)
        view.center = window.center
        
        view.alpha = 0.0
        window.addSubview(view)
        
        view.titleLabel?.text = title
        view.descriptionLabel?.text = message
        
        UIView.animate(withDuration: 0.35) {
            view.alpha = 1.0
        } completion: { (_) in
            
        }
    }
    
    @IBOutlet var animationView: AnimationView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.animationView?.animation = Animation.named("MortyErrorView")
        self.animationView?.loopMode = .autoReverse
        self.animationView?.play()
    }
    
    @IBAction func dismiss() {
        UIView.animate(withDuration: 0.35) {
            self.alpha = 0.0
        } completion: { (completed) in
            if (completed) {
                self.removeFromSuperview()
            }
        }
        
        MortyErrorView.currentErrorView = nil
    }
}
