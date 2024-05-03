//
//  HeavyComputationService.swift
//  IOS Test Assessment
//
//  Created by Focaloid on 03/05/24.
//

import Foundation

class HeavyComputationService {
    static func performHeavyComputation(for post: Post, completion: @escaping (String) -> Void) {
        // Simulate heavy computation
        // For demonstration purposes, let's use a simple delay
        DispatchQueue.global(qos: .background).async {
            Thread.sleep(forTimeInterval: 1)
            
            // Generate additional details
            let additionalDetails = "Additional details for post \(post.id)"
            
            // Pass additional details to the completion handler
            completion(additionalDetails)
        }
    }
}
