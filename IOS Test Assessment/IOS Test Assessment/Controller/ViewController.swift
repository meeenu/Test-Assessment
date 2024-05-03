//
//  ViewController.swift
//  IOS Test Assessment
//
//  Created by Focaloid on 03/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = UITableView.automaticDimension // Set row height to automatic
//        tableView.estimatedRowHeight = 200
        viewModel.fetchPosts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetail",
               let detailVC = segue.destination as? DetailViewController,
               let post = sender as? Post {
                detailVC.post = post
            }
        }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                    fatalError("Unable to dequeue PostTableViewCell")
                }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
        if let post = viewModel.post(at: indexPath.row) {
            cell.titlelabel?.text = "\(post.id): \(post.title)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let post = viewModel.post(at: indexPath.row) {
                performSegue(withIdentifier: "ShowDetail", sender: post)
            }
        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let boundsHeight = scrollView.bounds.height
            
            if offsetY > contentHeight - boundsHeight {
                guard !viewModel.isLoadingData else { return }
                
                viewModel.fetchPosts {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
}
