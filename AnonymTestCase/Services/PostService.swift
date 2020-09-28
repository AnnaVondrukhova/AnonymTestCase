//
//  PostService.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

protocol PostServiceDelegate {
    func showAlert(message: String)
}

class PostService {
    static let shared = PostService()
    
    //константа загрузки количества постов
    var first = 5
    var cursor: String? = ""
    
    var postsArray: [Post]?
    var delegate: PostListViewController!
    
    func getPostJSON(url: URL, completion: @escaping ([[String: Any]]) -> ()) {
        
        NetworkService.shared.getData(with: url) { (data, statusCode) in
            guard let data = data, statusCode == 200 else {
                var message = ""
                
                switch statusCode {
                case URLError.Code.notConnectedToInternet.rawValue:
                    message = "No internet connection"
                case URLError.Code.timedOut.rawValue:
                    message = "No internet connection"
                case 400:
                    message = "Bad request"
                case 500:
                    message = "Server is not responding"
                default:
                    message = "Server is not responding"
                }
                DispatchQueue.main.async {
                    self.delegate.showAlert(message: message)
                }
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let json = jsonObject as? [String: Any],
                    let data = json["data"] as? [String:Any] else {
                        completion([[String: Any]]())
                        return print("Invalid JSON")
                    }
                
                self.cursor = data["cursor"] as? String
                guard let posts = data["items"] as? [[String: Any]] else {
                    completion([[String: Any]]())
                        return print("Invalid JSON")
                    }

                completion(posts)
            } catch {
                completion([[String: Any]]())
                print("JSON parsing error: " + error.localizedDescription)
            }
            
        }
    }
    
    func fetchPosts(orderBy: SortType, completion: @escaping([Post]) -> ()) {
        guard self.cursor != nil else { return }
        var fetchedPosts = [Post]()
        
        var urlComponents = URLComponents(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts")
        urlComponents?.queryItems = [
            URLQueryItem(name: "first", value: "\(first)"),
            URLQueryItem(name: "orderBy", value: orderBy.rawValue),
            URLQueryItem(name: "after", value: cursor)
        ]
        
        let characterSet = CharacterSet(charactersIn: "+").inverted
        let query = urlComponents?.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: characterSet)
        urlComponents?.percentEncodedQuery = query

        guard let url = urlComponents?.url else { return }
        
        getPostJSON(url: url) { (posts) in
            for postDict in posts {
                let authorDict = postDict["author"] as? [String:Any] ?? [String:Any]()
                let author = User(dict: authorDict)
                
                let statsDict = postDict["stats"] as? [String:Any] ?? [String:Any]()
                let stats = Stats(stats: statsDict)
                
                guard let post = Post(dict: postDict, author: author, stats: stats) else { continue }
                fetchedPosts.append(post)
            }
            
            print (self.cursor)
            
            DispatchQueue.main.async {
                completion(fetchedPosts)
            }
        }
        
    }

}
