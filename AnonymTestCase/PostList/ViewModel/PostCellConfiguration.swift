//
//  PostCellConfiguration.swift
//  AnonymTestCase
//
//  Created by Anya on 25.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class PostCellConfiguration {
    
    static func setPostCellView(with post: Post) -> PostCellViewModel {
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy HH:mm"
            return df
        }()
        
        let postCellLayoutCalculator = PostCellLayoutCalculator()
        
        let createdAtDate = Date(timeIntervalSince1970: TimeInterval(post.createdAt)/1000)
        let createdAtString = dateFormatter.string(from: createdAtDate)
        
        let sizes = postCellLayoutCalculator.sizes(postText: post.text, postImage: post.images.first, tags: post.tags)
        
        
        
        return PostCellViewModel.init(authorPhotoUrl: post.author.extraSmallPhoto,
                                 authorName: post.author.name,
                                 createdAt: createdAtString,
                                 postText: post.text,
                                 postImage: post.images.first,
                                 tagsText: post.tags,
                                 likes: String(post.stats.likes),
                                 comments: String(post.stats.comments),
                                 views: String(post.stats.views),
                                 isLiked: post.isLiked,
                                 sizes: sizes)
    }
}
