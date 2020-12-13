//
//  DetailPostViewController.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    //MARKS: Variable & Outles
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionPostLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var phoneUserLabel: UILabel!
    @IBOutlet weak var websiteUserLabel: UILabel!
 
    @IBOutlet weak var tableView: UITableView!
    
    private var comments: [Comment] = []
    private var user: User = User()
    private let presenter = DetailPostPresenter()
    
    //MARKS: Circle of life
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(favoriteTapped))
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getDescription()
        presenter.getService()
        
    }
    
    @objc private func favoriteTapped(){
        
    }
}

extension DetailPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! DetailPostTableViewCell
        let comment = comments[indexPath.row]
        cell.setup(comment: comment)
        return cell
    }
}

extension DetailPostViewController: ServiceDetailPostView {
    func setDescription(description: String) {
        self.descriptionPostLabel.text = description
    }
    
    func startCallingService() {
        
    }
    
    func finishCallService() {
        
    }
    
    func setEmpty() {
        
    }
    
    func setError(error: String?) {
        
    }
    
    func setUser(user: User) {
        self.user = user
        
        self.nameUserLabel.text = user.name
        self.emailUserLabel.text = user.email
        self.phoneUserLabel.text = user.phone
        self.websiteUserLabel.text = user.website
    }
    
    func setComments(comments: [Comment]) {
        self.comments = comments
        tableView.reloadData()
    }
        
    func setArray(ObjectCodable: Array<Any>) {
        
    }
    
}
