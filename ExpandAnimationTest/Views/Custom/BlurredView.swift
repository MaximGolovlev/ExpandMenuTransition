//
//  BlurView.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//

import UIKit


class BlurredView: UIView {
    
    private let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let backgroundView: UIView = {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    init() {
        super.init(frame: .zero)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        layer.masksToBounds = true
        
        backgroundColor = .clear

        addSubview(blurredEffectView)
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(backgroundView)
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
