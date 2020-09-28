//
//  Post.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import UIKit

class Post {
    let author: User
    var text: String?
    var images = [Image]()
    var tags: String?
    var createdAt: Int
    var stats: Stats
    var isLiked = false
    
    init?(dict: [String:Any], author: User, stats: Stats) {
        guard let contents = dict["contents"] as? [[String:Any]] else { return nil}
        
        for content in contents {
            if let type = content["type"] as? String,
                let data = content["data"] as? [String:Any] {
                switch type {
                case "TEXT":
                    if let text = data["value"] as? String {
                        self.text = text
                    }
                case "IMAGE":
                    if let smallData = data["small"] as? [String:Any] {
                        guard let image = Image(dict: smallData) else { continue }
                        self.images.append(image)
                    } else if let extraSmallData = data["extraSmall"] as? [String:Any] {
                        guard let image = Image(dict: extraSmallData) else { continue }
                        self.images.append(image)
                    }
                case "TAGS":
                    if let tags = data["values"] as? [String] {
                        var tagsString = ""
                        for tag in tags {
                            tagsString.append("#\(tag) ")
                        }
                        self.tags = tagsString
                    }
                default:
                    continue
                }
            }
        }
        
        self.author = author
        self.stats = stats
        self.createdAt = dict["createdAt"] as? Int ?? 0
    }
    
    
}
