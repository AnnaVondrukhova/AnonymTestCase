//
//  DownloadImageService.swift
//  AnonymTestCase
//
//  Created by Anya on 23.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import UIKit

class DownloadImageService {
    static let shared = DownloadImageService()
    
    func downloadImage(urlString: String, completion:  @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            print("Image from cache")
            if let image = UIImage(data: cachedResponse.data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            return
        }
        
        print("Image from internet")
        NetworkService.shared.getData(with: url) { (data, statusCode) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
