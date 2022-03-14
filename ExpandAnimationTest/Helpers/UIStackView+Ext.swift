//
//  UIStackView+Ext.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 13.03.2022.
//

import Foundation

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func removeArrangedSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
