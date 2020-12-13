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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(favoriteTapped))
        presenter.attachView(view: self)
        
        configureButton(button: allButton,
                        corners: [.topLeft, .bottomLeft])
        configureButton(button: favoriteButton,
                        corners: [.topRight, .bottomRight])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPost()
    }
    
    @objc private func favoriteTapped(){
        
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        
        if(sender == allButton) {
            isSelectedButton(selected: true,
                             button: allButton)
            isSelectedButton(selected: false,
                             button: favoriteButton)
        } else {
            isSelectedButton(selected: false,
                             button: allButton)
            isSelectedButton(selected: true,
                             button: favoriteButton)
        }
    }
    
    private func setup() {
        
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
    
    private func configureButton(button: UIButton, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: button.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: 4, height: 4))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        button.layer.mask = maskLayer
        
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
        cell.setup(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        presenter.savePostSelected(post: post)
        self.performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}

extension PostViewController: ServiceTableView {
    
    func startCallingService() {
        
    }
    
    func finishCallService() {
        tableView.reloadData()
        
        isSelectedButton(selected: true,
                         button: allButton)
        isSelectedButton(selected: false,
                         button: favoriteButton)
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
