//
//  MenuIconCollection.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//

import UIKit

class MenuIconCollection: UIView {
    
    typealias Appearance = MenuViewAppearance
    
    var scrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    var sectionsContainer: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    var sectionContainer: UIStackView {
        let s = UIStackView()
        s.axis = .horizontal
        s.distribution = .fillEqually
        return s
    }
    
    var header: UIView = {
        $0.snp.makeConstraints({ $0.height.equalTo(Appearance.expandedTopOffset) })
        return $0
    }(UIView())
    
    var footer: UIView = {
        $0.snp.makeConstraints({ $0.height.equalTo(Appearance.expandedBotOffset) })
        return $0
    }(UIView())
    
    private var buttons = [IconButton]()
    
    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(scrollView)
        scrollView.autoresizesSubviews = true
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(sectionsContainer)
        sectionsContainer.snp.makeConstraints({ $0.edges.width.equalToSuperview() })
    }
    
    func update(buttons: [IconButton], viewMode: CardViewMode) {
        
        guard sectionsContainer.arrangedSubviews.isEmpty else { return }
        
        sectionsContainer.removeArrangedSubviews()
        
        sectionsContainer.addArrangedSubview(header)
        
        self.buttons = buttons
        self.buttons.forEach({ $0.beginUpdateLayout(viewMode: viewMode, newFrame: .zero) })
        
        var items = buttons
        
        while !items.isEmpty {
            let rows = Array(items.prefix(2))
            let section = sectionContainer
            section.addArrangedSubviews(rows)
            if rows.count == 1 {
                section.addArrangedSubview(UIView())
            }
            sectionsContainer.addArrangedSubview(section)
            items = Array(items.dropFirst(2))
        }
        
        sectionsContainer.addArrangedSubview(footer)
        
        sectionsContainer.addArrangedSubview(UIView())
        
    }
}

extension MenuIconCollection: CardView {
    
    func beginUpdateLayout(viewMode: CardViewMode, newFrame: CGRect) {
        header.isHidden = viewMode == .card
        footer.isHidden = viewMode == .card
        buttons.forEach({ $0.beginUpdateLayout(viewMode: viewMode, newFrame: newFrame) })
        
        if newFrame.width > 0 {
            sectionsContainer.snp.remakeConstraints({
                $0.edges.equalToSuperview()
                $0.width.equalTo(newFrame.width)
            })
        }
        
        scrollView.setContentOffset(.zero, animated: false)
        scrollView.isScrollEnabled = viewMode == .full
        scrollView.showsVerticalScrollIndicator = viewMode == .full
    }
    
    
    func endUpdateLayout(viewMode: CardViewMode, newFrame: CGRect) {
        
    }
    
    func animateLayout(viewMode: CardViewMode) {
        buttons.forEach({ $0.animateLayout(viewMode: viewMode) })
    }
}

