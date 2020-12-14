//
//  PostViewController.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import UIKit
import KVNProgress

class PostViewController: BaseViewController {
    
    //MARKS: Variables & outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var notFoundPostLabel: UILabel!
    
    private var posts: [Post] = []
    private let presenter = PostPresenter()
    
    //MARK: - Circle of life
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.icloud"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(refreshTapped))
        presenter.attachView(view: self)
        
        configureButton(button: allButton)
        configureButton(button: favoriteButton)
        isSelectedButton(selected: true,
                         button: allButton)
        isSelectedButton(selected: false,
                         button: favoriteButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        presenter.isSavedPostsInRealm() ? presenter.getAllPostInRealm() :
                                          presenter.getPostsService()
    }
    
    //MARK: - Setup
    private func setup() {
        deleteButton.setTitle("deleteButton".localized, for: .normal)
        allButton.setTitle("all".localized, for: .normal)
        favoriteButton.setTitle("favorites".localized, for: .normal)
        navigationItem.title = "post".localized
        notFoundPostLabel.text = "noPosts".localized
    }
    
    //MARK: - Actions
    @objc private func refreshTapped(){
        presenter.deleteAllPostInRealm()
        presenter.getPostsService()
        isSelectedButton(selected: true,
                         button: allButton)
        isSelectedButton(selected: false,
                         button: favoriteButton)
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        
        if(sender == allButton) {
            isSelectedButton(selected: true,
                             button: allButton)
            isSelectedButton(selected: false,
                             button: favoriteButton)
            presenter.getAllPostInRealm()
        } else {
            isSelectedButton(selected: false,
                             button: allButton)
            isSelectedButton(selected: true,
                             button: favoriteButton)
            presenter.getFavoritePostsInRealm()
        }
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        presenter.deleteAllPostInRealm()
        presenter.getAllPostInRealm()
        
        isSelectedButton(selected: true,
                         button: allButton)
        isSelectedButton(selected: false,
                         button: favoriteButton)
        
    }
    
    private func isSelectedButton(selected: Bool,
                                  button: UIButton) {
        if(selected) {
            button.isSelected = selected
            button.backgroundColor = .systemGreen
        } else {
            button.isSelected = selected
            button.backgroundColor = .white
        }
    }
    
    private func configureButton(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell",
                                                 for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.setup(post: post, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        presenter.savePostInUserDefault(post: post)
        presenter.setReadedInRealm(idPost: post.id.value!)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: "goToDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete) {
                let post = posts[indexPath.row]
                presenter.deletePostInRealm(idPost: post.id.value!,
                                          isAllSelected: self.allButton.isSelected)
            }
        }
}

extension PostViewController: ServiceTableView {

    func startCallingService() {
        KVNProgress.show(withStatus: "loading".localized,
                         on: navigationController?.view)
    }
    
    func finishCallService() {
        
        isSelectedButton(selected: true,
                         button: allButton)
        isSelectedButton(selected: false,
                         button: favoriteButton)
        KVNProgress.showSuccess(withStatus: "success".localized)
    }
    
    func startDelete() {
        KVNProgress.show(withStatus: "loading".localized, on: navigationController?.view)
    }
    
    func finishDelete() {
        KVNProgress.showSuccess(withStatus: "done".localized)
    }
        
    func setArray(ObjectCodable: Array<Any>) {
        guard let objectReady = ObjectCodable as? [Post] else {
            return
        }
        
        self.posts = objectReady
        tableView.reloadData()
        setEmpty()
    }
    
    func setEmpty() {
        if(posts.isEmpty) {
            self.tableView.isHidden = true
            self.notFoundPostLabel.isHidden = false
        } else {
            self.tableView.isHidden = false
            self.notFoundPostLabel.isHidden = true
        }
    }
    
    func setError(error: String?) {
        setEmpty()
        KVNProgress.showError(withStatus: "error".localized)
    }
}
