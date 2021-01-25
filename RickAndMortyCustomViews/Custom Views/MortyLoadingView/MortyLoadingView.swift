//
//  MortyLoadingView.swift
//  RickAndMorty
//
//  Created by Rafael Costa on 24/01/21.
//

import UIKit
import Lottie

public class MortyLoadingView: UIView {
    
    internal static var currentLoadingView: MortyLoadingView? = nil
    
    static func fromXIB() -> MortyLoadingView {
        let views = UINib(nibName: "MortyLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)
        
        guard let mortyLoadingView = views.first as? MortyLoadingView else {
            fatalError("Failure to decode XIB")
        }
        
        return mortyLoadingView
    }
    
    func show() {
        MortyLoadingView.currentLoadingView?.dismiss()
        MortyLoadingView.currentLoadingView = self
        
        guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else {
            return
        }
        
        window.addSubview(self)
        self.center = window.center
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.35) {
            self.alpha = 1.0
        } completion: { (completed) in
            
        }
    }
    
    @IBOutlet var animationView: AnimationView?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.animationView?.animation = Animation.named("MortyLoadingView")
        self.animationView?.loopMode = .autoReverse
        self.animationView?.play()
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.35) {
            self.alpha = 0.0
        } completion: { (completed) in
            if (completed) {
                self.removeFromSuperview()
            }
        }
        
        MortyLoadingView.currentLoadingView = nil
    }
}
