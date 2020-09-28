//
//  PostCellViewModel.swift
//  AnonymTestCase
//
//  Created by Anya on 25.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

struct PostCellViewModel {
    var authorPhotoUrl: String?
    var authorName: String
    var createdAt: String
    var postText: String?
    var postImage: Image?
    var tagsText: String?
    var likes: String
    var comments: String
    var views: String
    var isLiked: Bool
    var sizes: Sizes
}

struct Sizes {
    var postTextFrame: CGRect
    var postImageFrame: CGRect
    var tagsTextFrame: CGRect
    var statsViewFrame: CGRect
    var totalHeight: CGFloat
}
