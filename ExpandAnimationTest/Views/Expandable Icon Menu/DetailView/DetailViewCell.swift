//
//  DetailViewCell.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    private var mainContainer: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    var titleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        return $0
    }(UILabel())
    
    var subtitleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .light)
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(mainContainer)
        mainContainer.snp.makeConstraints({ $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)) })
        
        mainContainer.addArrangedSubviews([titleLabel, subtitleLabel])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

