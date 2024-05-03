//
//  PostViewModel.swift
//  IOS Test Assessment
//
//  Created by Focaloid on 03/05/24.
//

import Foundation
class PostViewModel {
    private var currentPage = 1
    private let limit = 10
    private var posts: [Post] = []
    var isLoadingData = false
    
    var numberOfPosts: Int {
        return posts.count
    }
    
    func fetchPosts(completion: @escaping () -> Void) {
        guard !isLoadingData else { return }
        isLoadingData = true
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(limit)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            
            do {
                let fetchedPosts = try JSONDecoder().decode([Post].self, from: data)
                self?.posts.append(contentsOf: fetchedPosts)
                completion()
                self?.isLoadingData = false
                self?.currentPage += 1
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func post(at index: Int) -> Post? {
        guard index >= 0 && index < posts.count else { return nil }
        return posts[index]
    }
}
