//
//  MenuButton.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 13.03.2022.
//

import UIKit

enum MenuIcon {
    
    case airplane
    case antenna
    case wifi
    case bluetooth
    case airdrop
    case hotspot
    
    var image: UIImage? {
        switch self {
        case .airplane:
            return UIImage(systemName: "airplane")
        case .antenna:
            return UIImage(systemName: "antenna.radiowaves.left.and.right")
        case .wifi:
            return UIImage(systemName: "wifi")
        case .bluetooth:
            return UIImage(systemName: "wave.3.left.circle.fill")
        case .airdrop:
            return UIImage(systemName: "dot.radiowaves.left.and.right")
        case .hotspot:
            return UIImage(systemName: "personalhotspot")
        }
    }
    
    var title: String? {
        switch self {
        case .airplane:
            return "Авиарежим"
        case .antenna:
            return "Сотовые данные"
        case .wifi:
            return "Wi-Fi"
        case .bluetooth:
            return "Bluetooth"
        case .airdrop:
            return "AirDrop"
        case .hotspot:
            return "Режим модема"
        }
    }
    
}
