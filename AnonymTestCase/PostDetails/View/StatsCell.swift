//
//  StatsCell.swift
//  AnonymTestCase
//
//  Created by Anya on 26.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {
    
    let statsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likesImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentsImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var delegate: PostDetailsViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        likesImageView.isUserInteractionEnabled = true
        likesImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeTapped(_:))))
        
        addSubviews()
        setUpConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSubviews() {
        contentView.addSubview(statsView)
        statsView.addSubview(likesImageView)
        statsView.addSubview(likesLabel)
        statsView.addSubview(commentsImageView)
        statsView.addSubview(commentsLabel)
        statsView.addSubview(viewsImageView)
        statsView.addSubview(viewsLabel)
    }
    
    func setUpConstraints() {
        
        let statsViewConstraints = [
            statsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            statsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.inset),
            statsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.inset),
            statsView.heightAnchor.constraint(equalToConstant: Constants.statsViewHeight)
        ]
        
        let likesViewConstraints = [
            likesImageView.topAnchor.constraint(equalTo: statsView.topAnchor, constant: 0.0),
            likesImageView.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 0.0),
            likesImageView.bottomAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 0.0),
            likesImageView.widthAnchor.constraint(equalTo: likesImageView.heightAnchor, multiplier: 1.0),
        ]
        
        let likesLabelConstraints = [
            likesLabel.topAnchor.constraint(equalTo: likesImageView.topAnchor, constant: 0.0),
            likesLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 5.0),
            likesLabel.heightAnchor.constraint(equalTo: likesImageView.heightAnchor, multiplier: 1.0),
            likesLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50.0)
        ]
        
        let commentsViewConstraints = [
            commentsImageView.topAnchor.constraint(equalTo: likesImageView.topAnchor, constant: 0.0),
            commentsImageView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 20),
            commentsImageView.heightAnchor.constraint(equalTo: likesImageView.heightAnchor, multiplier: 1.0),
            commentsImageView.widthAnchor.constraint(equalTo: commentsImageView.heightAnchor, multiplier: 1.0)
        ]
        
        let commentsLabelConstraints = [
            commentsLabel.topAnchor.constraint(equalTo: commentsImageView.topAnchor, constant: 0.0),
            commentsLabel.leadingAnchor.constraint(equalTo: commentsImageView.trailingAnchor, constant: 5.0),
            commentsLabel.heightAnchor.constraint(equalTo: commentsImageView.heightAnchor, multiplier: 1.0),
            commentsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50.0)
        ]
        
        let viewsViewConstraints = [
            viewsImageView.topAnchor.constraint(equalTo: commentsImageView.topAnchor, constant: 0.0),
            viewsImageView.heightAnchor.constraint(equalTo: commentsImageView.heightAnchor, multiplier: 1.0),
            viewsImageView.widthAnchor.constraint(equalTo: viewsImageView.heightAnchor, multiplier: 1.0)
        ]
        
        let viewsLabelConstraints = [
            viewsLabel.topAnchor.constraint(equalTo: commentsLabel.topAnchor, constant: 0.0),
            viewsLabel.leadingAnchor.constraint(equalTo: viewsImageView.trailingAnchor, constant: 5.0),
            viewsLabel.heightAnchor.constraint(equalTo: viewsImageView.heightAnchor, multiplier: 1.0),
            viewsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            viewsLabel.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: 0.0)
        ]
        
        NSLayoutConstraint.activate(statsViewConstraints)
        NSLayoutConstraint.activate(likesViewConstraints)
        NSLayoutConstraint.activate(likesLabelConstraints)
        NSLayoutConstraint.activate(commentsViewConstraints)
        NSLayoutConstraint.activate(commentsLabelConstraints)
        NSLayoutConstraint.activate(viewsViewConstraints)
        NSLayoutConstraint.activate(viewsLabelConstraints)
        
        contentView.bottomAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 15.0).isActive = true
    }
    
    func configure(with post: Post) {
        likesLabel.text = "\(post.stats.likes)"
        commentsLabel.text = "\(post.stats.comments)"
        viewsLabel.text = "\(post.stats.views)"
        
        if post.isLiked {
            likesImageView.image = UIImage(systemName: "heart.fill")
            likesImageView.tintColor = .red
        } else {
            likesImageView.image = UIImage(systemName: "heart")
            likesImageView.tintColor = .lightGray
        }
    }
    
    @objc func likeTapped(_ sender: UITapGestureRecognizer){
        guard let vc = delegate as? PostDetailsViewController else { return }
        vc.likesTapped(self)
    }

}
