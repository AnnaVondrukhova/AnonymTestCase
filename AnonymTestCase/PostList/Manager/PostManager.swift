//
//  PostManager.swift
//  AnonymTestCase
//
//  Created by Anya on 26.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

class PostManager {
    static var posts = [Post]()
    static var postCellViews = [PostCellViewModel]()
    
    static func likePost(at index: Int) {
        PostManager.posts[index].isLiked.toggle()
        PostManager.postCellViews[index].isLiked.toggle()
        
        if PostManager.posts[index].isLiked {
            PostManager.posts[index].stats.likes += 1
        } else {
            PostManager.posts[index].stats.likes -= 1
        }
        
        PostManager.postCellViews[index].likes = "\(PostManager.posts[index].stats.likes)"
    }
}
