//
//  Stats.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

struct Stats {
    var likes: Int = 0
    var views: Int = 0
    var comments: Int = 0
    var shares: Int = 0
    var replies: Int = 0
    
    init(stats: [String:Any]) {
        if let likes = stats["likes"] as? [String:Any] {
            self.likes = likes["count"] as? Int ?? 0
        }
        
        if let views = stats["views"] as? [String:Any] {
            self.views = views["count"] as? Int ?? 0
        }
        
        if let comments = stats["comments"] as? [String:Any] {
            self.comments = comments["count"] as? Int ?? 0
        }
        
        if let shares = stats["shares"] as? [String:Any] {
            self.shares = shares["count"] as? Int ?? 0
        }
        
        if let replies = stats["replies"] as? [String:Any] {
            self.replies = replies["count"] as? Int ?? 0
        }
    }
}
