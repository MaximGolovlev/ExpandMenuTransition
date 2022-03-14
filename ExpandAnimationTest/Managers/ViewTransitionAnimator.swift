//
//  ViewTransitionAnimator.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//

import UIKit


class ViewTransitionAnimator {
    
    private static func makeRevealAnimator(view: UIView, duration: Double = 0.1) -> UIViewPropertyAnimator {
        view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        view.isHidden = false
        view.alpha = 0.5
        return UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            view.alpha = 1
            view.transform = .identity
        }
    }
    
    private static func makeDismissAnimator(view: UIView, duration: Double = 0.1) -> UIViewPropertyAnimator {
        view.alpha = 1
        view.transform = .identity
        
        return UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            view.alpha = 0.5
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    static func swap(oldView: UIView, newView: UIView, completion: (() -> Void)? = nil) {
        
        dismiss(view: oldView) {
            reveal(view: newView, completion: completion)
        }
    }
    
    static func reveal(view: UIView, completion: (() -> Void)? = nil) {
        
        let animator = makeRevealAnimator(view: view)
        animator.addCompletion({ _ in
            view.isHidden = false
            completion?()
        })
        animator.startAnimation()
    }
    
    static func dismiss(view: UIView, completion: (() -> Void)? = nil) {
        
        let animator = makeDismissAnimator(view: view)
        animator.addCompletion({ _ in
            view.isHidden = true
            completion?()
        })
        animator.startAnimation()
    }
    
}
