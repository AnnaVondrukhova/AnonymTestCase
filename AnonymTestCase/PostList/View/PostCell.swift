//
//  PostCell.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

protocol LikesDelegate {
    associatedtype LikesDelegateCell
    func likesTapped(_ cell: LikesDelegateCell)
}

//protocol LikesDelegateCell {
//    var delegate: LikesDelegate? { get }
//}

class PostCell: UITableViewCell {
    
    let postBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //header
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    //post body
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        return label
    }()
    
    let postImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .blue
        return label
    }()
    
    //stats
    let statsView: UIView = {
        let view = UIView()
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
    
    var delegate: PostListViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.autoresizingMask = .flexibleHeight
        self.contentView.autoresizingMask = .flexibleWidth

        likesImageView.isUserInteractionEnabled = true
        likesImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeTapped(_:))))
        
        setFirstLayer()
        setSecondLayer()
        setThirdLayerOnHeader()
        setThirdLayerOnStats()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        postImageView.image = nil
    }
    
    func setFirstLayer() {
        contentView.addSubview(postBackView)
        
        postBackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        postBackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        postBackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        postBackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0).isActive = true
    }
    
    func setSecondLayer() {
        postBackView.addSubview(headerView)
        postBackView.addSubview(postTextLabel)
        postBackView.addSubview(postImageView)
        postBackView.addSubview(tagsLabel)
        postBackView.addSubview(statsView)
        
        headerView.topAnchor.constraint(equalTo: postBackView.topAnchor, constant: Constants.inset).isActive = true
        headerView.leadingAnchor.constraint(equalTo: postBackView.leadingAnchor, constant: Constants.inset).isActive = true
        headerView.trailingAnchor.constraint(equalTo: postBackView.trailingAnchor, constant: -Constants.inset).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Constants.postHeaderHeight).isActive = true
    }
    
    func setThirdLayerOnHeader() {
        headerView.addSubview(avatarImageView)
        headerView.addSubview(postAuthorLabel)
        headerView.addSubview(postDateLabel)
        
        avatarImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0.0).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0.0).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.postHeaderHeight).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        postAuthorLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0.0).isActive = true
        postAuthorLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.inset).isActive = true
        postAuthorLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0.0).isActive = true
        postAuthorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        postDateLabel.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor, constant: 10).isActive = true
        postDateLabel.leadingAnchor.constraint(equalTo: postAuthorLabel.leadingAnchor, constant: 0.0).isActive = true
        postDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        postDateLabel.trailingAnchor.constraint(equalTo: postAuthorLabel.trailingAnchor, constant: 0.0).isActive = true
    }
    
    func setThirdLayerOnStats(){
        statsView.addSubview(likesImageView)
        statsView.addSubview(likesLabel)
        statsView.addSubview(commentsImageView)
        statsView.addSubview(commentsLabel)
        statsView.addSubview(viewsImageView)
        statsView.addSubview(viewsLabel)
        
        likesImageView.topAnchor.constraint(equalTo: statsView.topAnchor, constant: 0.0).isActive = true
        likesImageView.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 0.0).isActive = true
        likesImageView.bottomAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 0.0).isActive = true
        likesImageView.widthAnchor.constraint(equalTo: likesImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        likesLabel.topAnchor.constraint(equalTo: likesImageView.topAnchor, constant: 0.0).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 5.0).isActive = true
        likesLabel.heightAnchor.constraint(equalTo: likesImageView.heightAnchor, multiplier: 1.0).isActive = true
        likesLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50.0).isActive = true
        
        commentsImageView.topAnchor.constraint(equalTo: likesImageView.topAnchor, constant: 0.0).isActive = true
        commentsImageView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 20).isActive = true
        commentsImageView.heightAnchor.constraint(equalTo: likesImageView.heightAnchor, multiplier: 1.0).isActive = true
        commentsImageView.widthAnchor.constraint(equalTo: commentsImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        commentsLabel.topAnchor.constraint(equalTo: commentsImageView.topAnchor, constant: 0.0).isActive = true
        commentsLabel.leadingAnchor.constraint(equalTo: commentsImageView.trailingAnchor, constant: 5.0).isActive = true
        commentsLabel.heightAnchor.constraint(equalTo: commentsImageView.heightAnchor, multiplier: 1.0).isActive = true
        commentsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50.0).isActive = true
        
        viewsImageView.topAnchor.constraint(equalTo: commentsImageView.topAnchor, constant: 0.0).isActive = true
        viewsImageView.heightAnchor.constraint(equalTo: commentsImageView.heightAnchor, multiplier: 1.0).isActive = true
        viewsImageView.widthAnchor.constraint(equalTo: viewsImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        viewsLabel.topAnchor.constraint(equalTo: commentsLabel.topAnchor, constant: 0.0).isActive = true
        viewsLabel.leadingAnchor.constraint(equalTo: viewsImageView.trailingAnchor, constant: 5.0).isActive = true
        viewsLabel.heightAnchor.constraint(equalTo: viewsImageView.heightAnchor, multiplier: 1.0).isActive = true
        viewsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: 0.0).isActive = true
    }
    
    func configure(with postCellView: PostCellViewModel) {
        if let authorPhotoUrl = postCellView.authorPhotoUrl {
            DownloadImageService.shared.downloadImage(urlString: authorPhotoUrl) { (image) in
                self.avatarImageView.image = image
            }
        } else {
            self.avatarImageView.image = UIImage(named: "no-avatar")
        }
        
        postAuthorLabel.text = postCellView.authorName
        postDateLabel.text = postCellView.createdAt
        postTextLabel.text = postCellView.postText
        tagsLabel.text = postCellView.tagsText
        likesLabel.text = postCellView.likes
        commentsLabel.text = postCellView.comments
        viewsLabel.text = postCellView.views
        
        postTextLabel.frame = postCellView.sizes.postTextFrame
        postImageView.frame = postCellView.sizes.postImageFrame
        tagsLabel.frame = postCellView.sizes.tagsTextFrame
        statsView.frame = postCellView.sizes.statsViewFrame
        
        if postCellView.isLiked {
            likesImageView.image = UIImage(systemName: "heart.fill")
            likesImageView.tintColor = .red
        } else {
            likesImageView.image = UIImage(systemName: "heart")
            likesImageView.tintColor = .lightGray
        }
        
        if let postImage = postCellView.postImage {
            DownloadImageService.shared.downloadImage(urlString: postImage.url) { (image) in
                if let image = image {
                    self.postImageView.image = image
                } else {
                    print("No post image got by url")
                    self.postImageView.image = UIImage(named: "no-image")
                }
            }
        } else {
            print("No post image")
        }
    }
    
    @objc func likeTapped(_ sender: UITapGestureRecognizer){
        guard let vc = delegate as? PostListViewController else { return }
        vc.likesTapped(self)
    }
    
}
