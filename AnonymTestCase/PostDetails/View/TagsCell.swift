//
//  TagsCell.swift
//  AnonymTestCase
//
//  Created by Anya on 26.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class TagsCell: UITableViewCell {

    let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .blue
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
        contentView.addSubview(tagsLabel)
    }
    
    func setUpConstraints() {
        let textConstraints = [
            tagsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            tagsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            tagsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(textConstraints)
        contentView.bottomAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 15.0).isActive = true
    }
    
    func configure(with post: Post) {
        if let tags = post.tags {
            tagsLabel.text = tags
        }
        
    }
}
