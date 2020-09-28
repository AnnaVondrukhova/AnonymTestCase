//
//  PostDetailsViewController.swift
//  AnonymTestCase
//
//  Created by Anya on 24.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

enum Section: Int, CaseIterable {
    case header
    case postText
    case postImages
    case postTags
    case stats
}


class PostDetailsViewController: UIViewController {
    
    var tableView = UITableView()
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        tableView.register(PostHeaderCell.self, forCellReuseIdentifier: "postHeaderCell")
        tableView.register(PostTextCell.self, forCellReuseIdentifier: "postTextCell")
        tableView.register(PostImageCell.self, forCellReuseIdentifier: "postImageCell")
        tableView.register(TagsCell.self, forCellReuseIdentifier: "tagsCell")
        tableView.register(StatsCell.self, forCellReuseIdentifier: "statsCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }

}

extension PostDetailsViewController: UITableViewDelegate, UITableViewDataSource, LikesDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        let post = PostManager.posts[index]
        switch section {
        case .header:
            return 1
        case .postText:
            guard post.text != nil else {return 0}
            return 1
        case .postImages:
            return post.images.count
        case .postTags:
            guard post.tags != nil else {return 0}
            return 1
        case .stats:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        let post = PostManager.posts[index]
        switch section {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postHeaderCell") as? PostHeaderCell else {
                return PostHeaderCell()
            }
            cell.configure(with: post)
            return cell
        case .postText:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTextCell") as? PostTextCell else {
                return PostTextCell()
            }
            cell.configure(with: post)
            return cell
        case .postImages:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postImageCell") as? PostImageCell else {
                return PostImageCell()
            }
            
            if !post.images.isEmpty {
                let image = post.images[indexPath.row]
                cell.configure(with: image)
                return cell
            } else {
                return PostImageCell()
            }
        case .postTags:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell") as? TagsCell else {
                return TagsCell()
            }
            cell.configure(with: post)
            return cell
        case .stats:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell") as? StatsCell else {
                return StatsCell()
            }
            cell.delegate = self
            cell.configure(with: post)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let contentWidth = screenWidth - Constants.inset*2
        guard let section = Section(rawValue: indexPath.section) else { return 0 }
        let post = PostManager.posts[index]
        
        switch section {
        case .header:
            return 2*Constants.inset+Constants.postHeaderHeight
        case .postText:
            guard let text = post.text else { return 0}
            return text.height(width: contentWidth, font: Constants.postTextLabelFont) + Constants.inset
        case .postImages:
            let imageHeight = post.images[indexPath.row].size.height
            let imageWidth = post.images[indexPath.row].size.width
            let ratio = imageHeight/imageWidth
            
            let imageAdaptedWidth = contentWidth
            let imageAdaptedHeight = imageAdaptedWidth*ratio
            
            return imageAdaptedHeight + Constants.inset
        case .postTags:
            guard let tagsText = post.tags else { return 0 }
            return tagsText.height(width: contentWidth, font: Constants.postTextLabelFont) + Constants.inset
        case .stats:
            return Constants.statsViewHeight + Constants.inset
        }
    }
    
    func likesTapped(_ cell: StatsCell) {
        PostManager.likePost(at: index)
        cell.configure(with: PostManager.posts[index])
    }
    
}
