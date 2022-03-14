//
//  Animator.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 11.03.2022.
//

import UIKit

protocol CardView: UIView {
    func beginUpdateLayout(viewMode: CardViewMode, newFrame: CGRect)
    func animateLayout(viewMode: CardViewMode)
    func endUpdateLayout(viewMode: CardViewMode, newFrame: CGRect)
}

enum CardViewMode {
    case card
    case full
    
    var next: CardViewMode { return self == .card ? .full : .card }
}

enum CardTransitionType {
    case collapsed
    case expanded
    
    func cornerRadius(old: CGFloat, new: CGFloat) -> CGFloat {
        return self == .collapsed ? old : new
    }
    
    var cardMode: CardViewMode { return self == .collapsed ? .card : .full }
    var next: CardTransitionType { return self == .collapsed ? .expanded : .collapsed }
    
}

class CardOpenAnimator {
    
    var cardView: CardView
    var expandContainer: UIView
    var superview: UIView
    var cardViewFrame: CGRect
    var containerFrame: CGRect
    
    var oldCornerRadius: CGFloat
    var newCornerRadius: CGFloat
    
    var transition: CardTransitionType = .collapsed
    let transitionDuration: Double = 0.5
    let shrinkDuration: Double = 0.1
    
    var nextFrame: CGRect { self.transition.next == .collapsed ? self.cardViewFrame : self.containerFrame }
    
    init(cardView: CardView, expandContainer: UIView, superview: UIView) {
        self.superview = superview
        self.cardView = cardView
        self.expandContainer = expandContainer
        self.cardViewFrame = cardView.frame
        self.containerFrame = expandContainer.frame
        self.oldCornerRadius = cardView.layer.cornerRadius
        self.newCornerRadius = expandContainer.layer.cornerRadius
    }
    
    private func makeShrinkAnimator() -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: shrinkDuration, curve: .easeOut) {
            self.cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func makeExpandContractAnimator() -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.85, initialVelocity: CGVector(dx: 0, dy: 1))
        let animator = UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            self.cardView.transform = .identity
            self.cardView.layer.cornerRadius = self.transition.next.cornerRadius(old: self.oldCornerRadius, new: self.newCornerRadius)
            self.cardView.frame = self.nextFrame
            self.cardView.animateLayout(viewMode: self.transition.next.cardMode)
        }
        
        return animator
    }
    
    func runPresentAnimation(completion: (() -> Void)?) {
        
        guard self.transition == .collapsed else { return }
        
        let shrinkAnimator = makeShrinkAnimator()
        let expandContractAnimator = makeExpandContractAnimator()
        
        expandContractAnimator.addCompletion { _ in
            self.cardView.endUpdateLayout(viewMode: self.transition.next.cardMode, newFrame: self.nextFrame)
            self.transition = self.transition.next
            completion?()
        }
        
        shrinkAnimator.addCompletion { _ in
            self.cardView.beginUpdateLayout(viewMode: self.transition.next.cardMode, newFrame: self.nextFrame)
            expandContractAnimator.startAnimation()
        }
        
        shrinkAnimator.startAnimation()
    }
    
    func runDismissAnimation(completion: (() -> Void)?) {
        
        guard self.transition == .expanded else { return }
        
        let expandContractAnimator = makeExpandContractAnimator()
        
        expandContractAnimator.addCompletion { _ in
            self.cardView.endUpdateLayout(viewMode: self.transition.next.cardMode, newFrame: self.nextFrame)
            self.transition = self.transition.next
            completion?()
        }
        
        cardView.beginUpdateLayout(viewMode: self.transition.next.cardMode, newFrame: self.nextFrame)
        expandContractAnimator.startAnimation()
    }
    
}


