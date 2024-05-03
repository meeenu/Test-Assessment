//
//  DetailViewController.swift
//  IOS Test Assessment
//
//  Created by Focaloid on 03/05/24.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var post: Post?
    private var additionalDetails: String?
    @IBOutlet var detailLabel: UILabel!
    override func viewDidLoad() {
         super.viewDidLoad()
         
         if let post = post {
             if let cachedDetails = additionalDetails {
                 // Use cached details if available
                 detailLabel.text = cachedDetails
             } else {
                 // Perform heavy computation only if data is not cached
                 HeavyComputationService.performHeavyComputation(for: post) { [weak self] details in
                     // Cache the computed details
                     self?.additionalDetails = details
                     
                     // Update UI with additional details
                     DispatchQueue.main.async {
                         self?.detailLabel.text = details
                     }
                 }
             }
         }
     }
}
