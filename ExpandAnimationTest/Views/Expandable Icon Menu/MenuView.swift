//
//  MenuView.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 13.03.2022.
//

import UIKit

struct MenuViewAppearance {
    
    static var iconSize = CGSize(width: 140, height: 140)
    static var iconInsets: CGFloat = 10
    static var buttonSize: CGSize {
        let side = (iconSize.height - iconInsets * 4) / 2
        return CGSize(width: side, height: side)
    }
    static var cornerRadiusBig: CGFloat = 36
    static var cornerRadiusSmall: CGFloat = 24
    static var expandContainerSize = CGSize(width: 300, height: 430)
    static var expandedTopOffset: CGFloat = 20
    static var expandedBotOffset: CGFloat = 20
}

class MenuView: UIView {
    
    typealias Appearance = MenuViewAppearance
    
    lazy var animator = CardOpenAnimator(cardView: self.iconsCollection, expandContainer: self.expandContainer, superview: self)
    
    lazy var iconsCollection: MenuIconView = {
        $0.layer.cornerRadius = Appearance.cornerRadiusSmall
        $0.longPressHandler = { [weak self] in
            self?.animator.runPresentAnimation(completion: {
                print("animated")
            })
        }
        $0.buttonLongPressHandler = { [weak self] in
            self?.presentDetailView()
        }
        return $0
    }(MenuIconView())
    
    var expandContainer: UIView = {
        $0.layer.cornerRadius = Appearance.cornerRadiusBig
        return $0
    }(UIView())
    
    lazy var tapGesture: UITapGestureRecognizer = {
        $0.delegate = self
        $0.addTarget(self, action: #selector(tapGestureHandler))
        return $0
    }(UITapGestureRecognizer())
    
    lazy var detailView: DetailView = {
        $0.isHidden = true
        return $0
    }(DetailView())
    
    init() {
        super.init(frame: .zero)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addGestureRecognizer(tapGesture)
        backgroundColor = .clear
        
        addSubview(expandContainer)
        expandContainer.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalTo(Appearance.expandContainerSize)
        })
        
        addSubview(iconsCollection)
        iconsCollection.snp.makeConstraints({
            $0.size.equalTo(Appearance.iconSize)
            $0.top.equalTo(100)
            $0.left.equalTo(50)
        })
        
        addSubview(detailView)
        detailView.snp.makeConstraints({
            $0.edges.equalTo(self.expandContainer.snp.edges)
        })
        
    }
    
    @objc private func tapGestureHandler(sender: UITapGestureRecognizer) {
        guard detailView.isHidden else {
            ViewTransitionAnimator.swap(oldView: detailView, newView: iconsCollection) {}
            return
        }
        animator.runDismissAnimation(completion: nil)
    }
    
    func update(icons: [MenuIcon]) {
        iconsCollection.update(icons: icons)
    }
    
    private func presentDetailView() {
        ViewTransitionAnimator.swap(oldView: iconsCollection, newView: detailView) {
            
        }
    }
}

extension MenuView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         return touch.view == self
    }
    
}


