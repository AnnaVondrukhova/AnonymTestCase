//
//  PostListViewController.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

enum SortType: String {
    case mostPopular = "mostPopular"
    case mostCommented = "mostCommented"
    case createdAt = "createdAt"
}

class PostListViewController: UIViewController,  PostServiceDelegate{
    
    var sortLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by: "
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sortButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.darkGray, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Sort type", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tableView = UITableView()
    
    var refreshControl = UIRefreshControl()
    var downloadNeeded = false
    private var sortType: SortType = .mostPopular {
        didSet {
            sortButton.setTitle(sortType.rawValue, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSortElements()
        setupTableView()
        sortButton.setTitle(sortType.rawValue, for: .normal)
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        PostService.shared.delegate = self
        
        updateResults()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        tableView.register(PostCell.self, forCellReuseIdentifier: "postCell")
        tableView.register(ActivityIndicatorCell.self, forCellReuseIdentifier: "activityIndicatorCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSortElements() {
        view.addSubview(sortLabel)
        view.addSubview(sortButton)
        
        sortLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        sortLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        sortLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        sortLabel.widthAnchor.constraint(equalToConstant: 65.0).isActive = true
        
        sortButton.topAnchor.constraint(equalTo: sortLabel.topAnchor).isActive = true
        sortButton.leadingAnchor.constraint(equalTo: sortLabel.trailingAnchor, constant: 8).isActive = true
        sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        sortButton.heightAnchor.constraint(equalTo: sortLabel.heightAnchor).isActive = true
    }
    
    @objc func sortButtonTapped() {
        let alertController = UIAlertController(title: "Sort options", message: nil, preferredStyle: .actionSheet)
        let mostPopularAction = UIAlertAction(title: SortType.mostPopular.rawValue, style: .default) { (_) in
            self.sortType = .mostPopular
            self.updateResults()
        }
        let mostCommentedAction = UIAlertAction(title: SortType.mostCommented.rawValue, style: .default) { (_) in
            self.sortType = .mostCommented
            self.updateResults()
        }
        let createdAtAction = UIAlertAction(title: SortType.createdAt.rawValue, style: .default) { (_) in
            self.sortType = .createdAt
            self.updateResults()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(mostPopularAction)
        alertController.addAction(mostCommentedAction)
        alertController.addAction(createdAtAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        if PostManager.posts.isEmpty {
            PostService.shared.fetchPosts(orderBy: sortType) { (posts) in
                PostManager.posts = posts
                PostManager.postCellViews = posts.map{ (post) in
                    PostCellConfiguration.setPostCellView(with: post)
                }
                self.downloadNeeded = true
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        } else {
            self.refreshControl.endRefreshing()
        }
    }
    
    func updateResults() {
        PostService.shared.cursor = ""
        PostService.shared.fetchPosts(orderBy: sortType) { (posts) in
            PostManager.posts = posts
            PostManager.postCellViews = posts.map{ (post) in
                PostCellConfiguration.setPostCellView(with: post)
            }
            self.downloadNeeded = true
            self.tableView.reloadData()
        }
    }
    
    func showAlert(message: String) {
        AlertService.showNetworkAlert(in: self, message: message)
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource, LikesDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if PostManager.posts.isEmpty {
                tableView.backgroundView = setUpBackgroundLabel()
                tableView.separatorStyle = .none
                return 0
            } else {
                tableView.backgroundView = nil
                return PostManager.posts.count
            }
        } else if section == 1&&downloadNeeded {
            return 1
        } else {
            return 0
        }
    }
    
    func setUpBackgroundLabel() -> UILabel {
        let backgroundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundLabel.text = "No Data"
        backgroundLabel.font = .systemFont(ofSize: 27, weight: .semibold)
        backgroundLabel.textColor = .lightGray
        backgroundLabel.textAlignment = .center
        return backgroundLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostCell else { return PostCell() }
            let postCellView = PostManager.postCellViews[indexPath.row]
            cell.delegate = self
            cell.configure(with: postCellView)
            //            cell.layoutIfNeeded()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "activityIndicatorCell") as? ActivityIndicatorCell else { return PostCell() }
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPostDetails", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PostManager.postCellViews[indexPath.row].sizes.totalHeight
    }
    
    func likesTapped(_ cell: PostCell) {
        let indexPath = self.tableView.indexPath(for: cell)!
        PostManager.likePost(at: indexPath.row)
        cell.configure(with: PostManager.postCellViews[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
            if downloadNeeded {
                downloadMorePosts()
            }
        }
    }
    
    func downloadMorePosts() {
        downloadNeeded = false
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        
        PostService.shared.fetchPosts(orderBy: sortType) { (posts) in
            PostManager.posts.append(contentsOf: posts)
            PostManager.postCellViews.append(contentsOf: posts.map{ (post) in
                PostCellConfiguration.setPostCellView(with: post)
            })
            self.downloadNeeded = true
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = sender as? Int else { return }
        guard let vc = segue.destination as? PostDetailsViewController else { return }
        vc.index = index
    }
    
}

