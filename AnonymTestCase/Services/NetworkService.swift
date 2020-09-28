//
//  NetworkService.swift
//  AnonymTestCase
//
//  Created by Anya on 22.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    var nextPageExist: Bool = false
    
    //общая функция для всех запросов
    func getData(with url: URL, completion: @escaping (Data?, Int) -> ()) {
        print(url)
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 7.0
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            print("Data from cachе")
            
            let data = cachedResponse.data
            let statusCode = (cachedResponse.response as? HTTPURLResponse)?.statusCode ?? 500
            
            completion(data, statusCode)
            return
        }
        
        print("Data from internet")
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    if let err = error as? URLError, [URLError.Code.notConnectedToInternet, URLError.Code.timedOut].contains(err.code) {
                        completion(nil, err.code.rawValue)
                    } else {
                        completion(nil, 500)
                    }
                    
                    return
            }
            
            print("Status code: ", response.statusCode)
            self.cacheData(data: data, response: response)
            completion(data, response.statusCode)
            
        }
        dataTask.resume()
    }
    
    func cacheData(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
    
}
