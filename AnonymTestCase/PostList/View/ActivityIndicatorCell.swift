//
//  ActivityIndicatorCell.swift
//  AnonymTestCase
//
//  Created by Anya on 23.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class ActivityIndicatorCell: UITableViewCell {

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(activityIndicator)
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupConstraints() {
        let indicatorConstraints = [
            activityIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(indicatorConstraints)
        contentView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}
