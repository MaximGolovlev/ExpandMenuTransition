//
//  ToggleButton.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//


import UIKit

class UIToggleButton: UIButton {
    var isOn:Bool = false{
        didSet{
            updateDisplay()
        }
    }
    var onImage:UIImage! = nil{
        didSet{
            updateDisplay()
        }
    }
    var offImage:UIImage! = nil{
        didSet{
            updateDisplay()
        }
    }
    
    var isAutotoggled: Bool = true
     
    func updateDisplay(){
        if isOn {
            if let onImage = onImage {
                backgroundColor = .systemBlue
                tintColor = .white
                setImage(onImage, for: .normal)
            }
        } else {
            if let offImage = offImage {
                backgroundColor = .white
                tintColor = .darkGray
                setImage(offImage, for: .normal)
            }
        }
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        toggleLayout()
    }
    
    func toggleLayout() {
        if !isOn {
            isOn.toggle()
            return
        }
        
        if isAutotoggled, isOn {
            isOn.toggle()
            return
        }
    }
}
