//
//  UIView+Ext.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//

import UIKit

extension UIView {
    
    func setMediumShadow() {
        self.setShadow(opacity: 0.3, radius: 3.5, offset: CGSize(width: 0, height: 3), color: .black)
    }
    
    func setShadow(opacity: CGFloat, radius: CGFloat, offset: CGSize, color:UIColor!) -> Void {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
}
