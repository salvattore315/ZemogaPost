//
//  PostViewController.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import UIKit

class PostViewController: UIViewController {
    
    //MARKS: Variables & outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var posts: [Post] = []
    private let presenter = PostPresenter()
    
    //MARKS: Circle of life
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteTapped))
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPost()    }
    
    @objc private func favoriteTapped(){
        
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.setup(post: post)
        return cell
    }
}

extension PostViewController: ServiceTableView {
    
    func startCallingService() {
        
    }
    
    func finishCallService() {
        tableView.reloadData()
    }
    
    func setArray(ObjectCodable: Array<Any>) {
        guard let objectReady = ObjectCodable as? [Post] else {
            return
        }
        
        self.posts = objectReady
    }
    
    func setEmpty() {
        
    }
    
    func setError(error: String?) {
        
    }
}
