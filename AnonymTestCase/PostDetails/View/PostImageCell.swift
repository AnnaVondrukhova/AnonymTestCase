//
//  PostImageCell.swift
//  AnonymTestCase
//
//  Created by Anya on 24.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class PostImageCell: UITableViewCell {
    
    let postImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                postImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                postImageView.addConstraint(aspectConstraint!)
            }
        }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func addSubviews() {
        contentView.addSubview(postImageView)
    }
    
    func setUpConstraints() {
        let imageConstraints = [
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        
    }
    
    func configure(with postImage: Image) {
        DownloadImageService.shared.downloadImage(urlString: postImage.url) { (image) in
            if let image = image {
                self.setCustomImage(image: image)
            } else {
                self.setCustomImage(image: UIImage(named: "no-image")!)
            }
        }
    }
    
    func setCustomImage(image: UIImage) {

        let aspect = image.size.height / image.size.width
        
        aspectConstraint = postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: CGFloat(aspect))
        
        let contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 15.0)
        contentViewBottomConstraint.priority = UILayoutPriority(999)
        contentViewBottomConstraint.isActive = true
        postImageView.image = image
    }
}
