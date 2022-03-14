//
//  MenuButton.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 13.03.2022.
//

import UIKit


class IconButton: UIView {
    
    typealias Appearance = MenuViewAppearance
    
    var longPressHandler: (() -> Void)?
    var tapHandler: (() -> Void)?
    
    var mainContainerView: UIStackView = {
        $0.alignment = .center
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector (tapSelected))
    lazy var longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressSelected))
    
    var header: UIView = {
        $0.snp.makeConstraints({ $0.height.equalTo(10) })
        return $0
    }(UIView())
    
    lazy var button: UIToggleButton = {
        let size = Appearance.buttonSize
        $0.layer.cornerRadius = size.height/2
        $0.snp.makeConstraints({ $0.size.equalTo(size) })
        $0.addGestureRecognizer(tapGesture)
        $0.addGestureRecognizer(longGesture)
        return $0
    }(UIToggleButton(type: .custom))
    
    var titleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    var statusLabel: UILabel = {
        $0.text = "Выкл"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    var footer: UIView = {
        $0.snp.makeConstraints({ $0.height.equalTo(10) })
        return $0
    }(UIView())
    
    init(frame: CGRect, icon: MenuIcon) {
        super.init(frame: frame)
        
        button.onImage = icon.image
        button.offImage = icon.image
        
        titleLabel.text = icon.title
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(mainContainerView)
        
        mainContainerView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(Appearance.iconInsets) })
        mainContainerView.addArrangedSubviews([header, button, titleLabel, statusLabel, footer])
        
        mainContainerView.setCustomSpacing(8, after: button)
        mainContainerView.setCustomSpacing(4, after: titleLabel)
    }
    
    @objc private func tapSelected(sender: UITapGestureRecognizer) {
        button.toggleLayout()
        tapHandler?()
    }
    
    @objc private func longPressSelected(sender: UITapGestureRecognizer) {
        if sender.state == .began {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            longPressHandler?()
        }
    }
    
}

extension IconButton: CardView {
    
    func beginUpdateLayout(viewMode: CardViewMode, newFrame: CGRect) {
        switch viewMode {
        case .card:
            header.isHidden = true
            titleLabel.isHidden = true
            statusLabel.isHidden = true
            footer.isHidden = true
        case .full:
            header.isHidden = false
            titleLabel.isHidden = false
            statusLabel.isHidden = false
            footer.isHidden = false
        }
    }
    
    func endUpdateLayout(viewMode: CardViewMode, newFrame: CGRect) {
        
    }
    
    
    func animateLayout(viewMode: CardViewMode) {
        
    }
}
