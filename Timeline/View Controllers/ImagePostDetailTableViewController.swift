//
//  ImagePostDetailTableViewController.swift
//  Timeline
//
//  Created by Spencer Curtis on 10/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ImagePostDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        
        guard let imageData = imageData,
            let image = UIImage(data: imageData) else { return }
        
        title = post?.title
        
        imageView.image = image
        
        titleLabel.text = post.title
        authorLabel.text = post.author.displayName
    }
    
    // MARK: - Action
    
    @IBAction func addComment(_ sender: Any) {
        
        presentActionSheet()
    }
    
    private func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Comment Type", message: nil, preferredStyle: .actionSheet)
        let text = UIAlertAction(title: "Text", style: .default) { (action) in
            self.presentTextComment()
        }
        
        let audio = UIAlertAction(title: "Audio", style: .default) { (action) in
            self.presentAudioCommentView()
        }
        
        actionSheet.addAction(text)
        actionSheet.addAction(audio)
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func presentTextComment() {
        let alert = UIAlertController(title: "Add a text comment", message: "Write your comment below:", preferredStyle: .alert)
        
        var commentTextField: UITextField?
        
        alert.addTextField { (textField) in
            textField.placeholder = "Comment:"
            commentTextField = textField
        }
        
        let addCommentAction = UIAlertAction(title: "Add Comment", style: .default) { (_) in
            
            guard let commentText = commentTextField?.text else { return }
            
            self.postController.addComment(with: commentText, to: &self.post!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addCommentAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Audio Comment View
    
    private func presentAudioCommentView() {
        guard let commentView = Bundle.main.loadNibNamed("AudioCommentView", owner: self, options: nil)?.first as? AudioCommentView else { return }
        
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(blurView)
        
        view.addSubview(commentView)
        commentView.center.y = self.view.center.y
        commentView.center.x = self.view.center.x
        commentView.layer.cornerRadius = 20
        commentView.layer.masksToBounds = true
        
        guard let cancelView = Bundle.main.loadNibNamed("CancelButtonView", owner: self, options: nil)?.first as? CancelButtonView else { return }
        view.addSubview(cancelView)
        cancelView.center.x = self.view.center.x
        cancelView.frame.origin.y = self.view.bounds.midY + commentView.frame.size.height
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (post?.comments.count ?? 0) - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        
        let comment = post?.comments[indexPath.row + 1]
        
        cell.textLabel?.text = comment?.text
        cell.detailTextLabel?.text = comment?.author.displayName
        
        return cell
    }
    
    
    // MARK: - Properties
    
    var post: Post!
    var postController: PostController!
    var imageData: Data?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageViewAspectRatioConstraint: NSLayoutConstraint!
}
