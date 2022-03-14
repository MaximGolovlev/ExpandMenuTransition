//
//  MainViewController.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 11.03.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let menuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(menuView)
        menuView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        menuView.update(icons: [.airplane, .antenna, .wifi, .bluetooth, .airdrop, .hotspot, .airplane])
    }
    
}
