//
//  AlertService.swift
//  AnonymTestCase
//
//  Created by Anya on 26.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    static func showNetworkAlert(in vc: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Network error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            if let vc = vc as? PostListViewController {
                vc.refreshControl.endRefreshing()
                vc.downloadNeeded = true
            }
            
        }
        alertController.addAction(okAction)
        
        vc.present(alertController, animated: true, completion: nil)

    }
    
}
