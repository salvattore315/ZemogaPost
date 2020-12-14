//
//  DetailPostViewController.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import UIKit
import KVNProgress

class DetailPostViewController: BaseViewController {
    
    //MARKS: Variable & Outles
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionPostTextView: UITextView!
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
    private var itemButton = UIButton()
    
    //MARK: - Circle of life
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post: Post = SessionManager.getCodableSession(key: GlobalConstants.Keys.savePostSelected) {
            let postRealm = presenter.getPostInRealm(idPost: post.id.value!)
            self.itemButton = UIButton(type: .custom)
            itemButton.setImage(UIImage(systemName: "star"), for: .normal)
            itemButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
            itemButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            itemButton.tintColor = .systemYellow
            itemButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
            itemButton.isSelected = (postRealm?.isFavorite ?? false) ? true : false
            let item = UIBarButtonItem(customView: itemButton)
            navigationItem.setRightBarButtonItems([item], animated: true)
        }
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
    
    //MARK: - Actions
    @objc private func favoriteTapped(_ sender: UIButton){
        if let post: Post = SessionManager.getCodableSession(key: GlobalConstants.Keys.savePostSelected) {
            presenter.setFavoritePostInRealm(idPost: post.id.value!)
        }
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
        self.descriptionPostTextView.text = description
    }
    
    func startCallingService() {
        KVNProgress.show(withStatus: "loading".localized,
                         on: navigationController?.view)
    }
    
    func finishCallService() {
        KVNProgress.showSuccess(withStatus: "success".localized)
    }
    
    func changeFavoriteButton(isFavorite: Bool) {
        self.itemButton.isSelected = isFavorite
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
        setEmpty()
        KVNProgress.showError {
            self.navigationController?.popViewController(animated: true)
        }
    }
        
    func setArray(ObjectCodable: Array<Any>) {
        
    }
    func startDelete() {
        
    }
    
    func finishDelete() {
        
    }
    
}
