//
//  User.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var extraSmallPhoto: String?
    var originalPhoto: String?
    
    init(dict: [String:Any]) {
        let name = dict["name"] as? String ?? "No name"
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let photo = dict["photo"] as? [String:Any],
            let photoData = photo["data"] as? [String:Any] {
                if let extraSmallData = photoData["extraSmall"] as? [String:Any],
                    let extraSmallUrl = extraSmallData["url"] as? String {
                        extraSmallPhoto = extraSmallUrl
                } else {
                    extraSmallPhoto = nil
            }
            
                if let originalData = photoData["original"] as? [String:Any],
                        let originalUrl = originalData["url"] as? String {
                            extraSmallPhoto = originalUrl
                } else {
                    originalPhoto = nil
                }
        } else {
            extraSmallPhoto = nil
            originalPhoto = nil
        }
    }
}
