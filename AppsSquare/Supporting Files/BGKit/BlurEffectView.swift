//
//  BlurEffectView.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import UIKit

class BlurEffectView: UIVisualEffectView {
    
    var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    override func didMoveToSuperview() {
       
        backgroundColor = .clear

        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .dark)
        }
        animator.fractionComplete = 0.4
    }
    
    deinit {
        animator.stopAnimation(true)
    }
}
