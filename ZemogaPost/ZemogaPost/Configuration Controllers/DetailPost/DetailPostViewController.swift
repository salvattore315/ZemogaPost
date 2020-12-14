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
 
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCommentsLabel: UILabel!
    
    private var comments: [Comment] = []
    private var user: User = User()
    private let presenter = DetailPostPresenter()
    
    //MARKS: Circle of life
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(image: UIImage(systemName: "star"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(favoriteTapped))
        item.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = item
        
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        presenter.getDescription()
        presenter.getService()
        
    }
    
    //MARK: - Setup
    private func setup() {
        navigationItem.title = "post".localized
        descriptionLabel.text = "description".localized
        userLabel.text = "user".localized
        
        nameLabel.text = "name".localized
        emailLabel.text = "email".localized
        phoneLabel.text = "phone".localized
        websiteLabel.text = "website".localized
        
        commentsLabel.text = "comments".localized
    }
    
    @objc private func favoriteTapped(){
        presenter.setReadPost()
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
        if(comments.isEmpty) {
            tableView.isHidden = true
            noCommentsLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noCommentsLabel.isHidden = true
        }
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
        setEmpty() 
    }
        
    func setArray(ObjectCodable: Array<Any>) {
        
    }
    
}
