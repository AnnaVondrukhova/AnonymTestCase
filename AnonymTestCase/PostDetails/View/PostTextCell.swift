//
//  PostTextCell.swift
//  AnonymTestCase
//
//  Created by Anya on 24.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class PostTextCell: UITableViewCell {
    
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setUpConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSubviews() {
        contentView.addSubview(postTextLabel)
    }
    
    func setUpConstraints() {
        let textConstraints = [
            postTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            postTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            postTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(textConstraints)
        contentView.bottomAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 15.0).isActive = true
    }
    
    func configure(with post: Post) {
        if let text = post.text {
            postTextLabel.text = text
        } 
    }

}
