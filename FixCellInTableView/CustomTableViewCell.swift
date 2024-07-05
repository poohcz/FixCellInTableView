//
//  CustomCell.swift
//  FixCellInTableView
//
//  Created by 김동율 on 7/5/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(indexLabel)
        
        NSLayoutConstraint.activate([
            indexLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indexLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
