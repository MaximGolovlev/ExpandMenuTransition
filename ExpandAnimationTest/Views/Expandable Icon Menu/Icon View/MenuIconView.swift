//
//  IconsCollectioView.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 11.03.2022.
//

import UIKit

class MenuIconView: BlurredView {
    
    typealias Appearance = MenuViewAppearance
    
    var longPressHandler: (() -> Void)?
    var buttonLongPressHandler: (() -> Void)?
    
    private lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressTapped))
    
    private lazy var collection: MenuIconCollection = {
        return $0
    }(MenuIconCollection())

    private var buttons = [IconButton]()
    
    private var viewMode: CardViewMode = .card
    
    override init() {
        super.init()
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        isUserInteractionEnabled = true
        layer.masksToBounds = true
        
        addGestureRecognizer(longPressGesture)
        
        backgroundColor = .clear

        backgroundView.addSubview(collection)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @objc private func longPressTapped(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            longPressHandler?()
        }
    }
    
    func update(icons: [MenuIcon], viewMode: CardViewMode = .card) {
        buttons = icons.map({
            let b = IconButton(frame: .zero, icon: $0)
            b.longPressHandler = { [weak self] in
                guard self?.viewMode != .card else { return }
                self?.buttonLongPressHandler?()
            }
            return b
        })
        update(buttons: buttons, viewMode: viewMode)
        collection.beginUpdateLayout(viewMode: viewMode, newFrame: .zero)
    }
    
    private func update(buttons: [IconButton], viewMode: CardViewMode) {
        collection.update(buttons: buttons, viewMode: viewMode)
    }
}

extension MenuIconView: CardView {
    
    func beginUpdateLayout(viewMode: CardViewMode, newFrame: CGRect) {
        self.viewMode = viewMode
        collection.beginUpdateLayout(viewMode: viewMode, newFrame: newFrame)
    }
    
    func animateLayout(viewMode: CardViewMode) {
        self.viewMode = viewMode
        collection.animateLayout(viewMode: viewMode)
    }
    
    func endUpdateLayout(viewMode: CardViewMode, newFrame: CGRect) {
        self.viewMode = viewMode
        update(buttons: buttons, viewMode: viewMode)
        collection.endUpdateLayout(viewMode: viewMode, newFrame: newFrame)
    }
}
