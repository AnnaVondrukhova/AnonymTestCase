//
//  PostHeaderCell.swift
//  AnonymTestCase
//
//  Created by Anya on 24.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    let avatarImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.bounds.size = CGSize(width: 60, height: 60)
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let postAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        return df
    }
    
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
        contentView.addSubview(avatarImageView)
        contentView.addSubview(postAuthorLabel)
        contentView.addSubview(postDateLabel)
    }
    
    func setUpConstraints() {
        let headerConstraints = [
            avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60.0),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1.0),
            
            postAuthorLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            postAuthorLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            postAuthorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            postAuthorLabel.heightAnchor.constraint(equalToConstant: 30),
            
            postDateLabel.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor, constant: 10),
            postDateLabel.leadingAnchor.constraint(equalTo: postAuthorLabel.leadingAnchor, constant: 0),
            postDateLabel.heightAnchor.constraint(equalToConstant: 20),
            postDateLabel.trailingAnchor.constraint(equalTo: postAuthorLabel.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(headerConstraints)
        contentView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15.0).isActive = true
    }
    
    func configure(with post: Post) {
        if let authorPhotoUrl = post.author.extraSmallPhoto {
            DownloadImageService.shared.downloadImage(urlString: authorPhotoUrl) { (image) in
                self.avatarImageView.image = image
            }
        } else {
            self.avatarImageView.image = UIImage(named: "no-avatar")
        }
        
        postAuthorLabel.text = post.author.name
        
        let createdAt = Date(timeIntervalSince1970: TimeInterval(post.createdAt)/1000)
        postDateLabel.text = dateFormatter.string(from: createdAt)
        
    }
    
}
