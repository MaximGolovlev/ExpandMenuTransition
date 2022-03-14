//
//  DetailView.swift
//  ExpandAnimationTest
//
//  Created by Maxim on 14.03.2022.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    var mainContainer: UIStackView = {
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


class DetailView: BlurredView {
    
    typealias Appearance = MenuViewAppearance
    
    struct Row {
        var title: String?
        var subtitle: String?
    }
    
    var mainContainer: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    var headerLabel: UILabel = {
        $0.text = "Bluetooth"
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.snp.makeConstraints({ $0.height.equalTo(100) })
        return $0
    }(UILabel())
    
    var cellId = "cellId"
    
    var topSeparator: UIView = {
        $0.backgroundColor = .white
        $0.snp.makeConstraints({ $0.height.equalTo(1/UIScreen.main.scale) })
        return $0
    }(UIView())
    
    lazy var tableView: UITableView = {
        $0.backgroundColor = .clear
        $0.separatorColor = .white
        $0.register(DetailViewCell.self, forCellReuseIdentifier: cellId)
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView())
    
    var botSeparator: UIView = {
        $0.backgroundColor = .white
        $0.snp.makeConstraints({ $0.height.equalTo(1/UIScreen.main.scale) })
        return $0
    }(UIView())
    
    var footerLabel: UILabel = {
        $0.text = "Настройки Bluetooth..."
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.snp.makeConstraints({ $0.height.equalTo(50) })
        return $0
    }(UILabel())
    
    var rows = [Row]()
    
    override init() {
        super.init()
        
        rows = [Row(title: "AM61", subtitle: "Не подкл."), Row(title: "iPad", subtitle: "Не подкл.")]
        
        layer.cornerRadius = Appearance.cornerRadiusBig
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(mainContainer)
        mainContainer.snp.makeConstraints({ $0.edges.equalToSuperview() })
        mainContainer.addArrangedSubviews([headerLabel, topSeparator, tableView, botSeparator, footerLabel])
    }
    
}


extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = rows[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DetailViewCell
        cell.titleLabel.text = row.title
        cell.subtitleLabel.text = row.subtitle
        return cell
    }
    
}


extension DetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
