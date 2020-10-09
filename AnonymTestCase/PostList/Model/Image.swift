//
//  Image.swift
//  AnonymTestCase
//
//  Created by Anya on 24.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

struct Image {
    let url: String
    let size: CGSize
    
    init?(dict: [String:Any]) {
        guard let url = dict["url"] as? String else { return nil }
        self.url = url
        
        if let size = dict["size"] as? [String: Int] {
            let imageSize = CGSize(width: CGFloat(size["width"] ?? 0), height: CGFloat(size["height"] ?? 0))
            self.size = imageSize
        } else {
            self.size = CGSize.zero
        }
    }
}
