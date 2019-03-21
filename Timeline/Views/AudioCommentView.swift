//
//  AudioCommentView.swift
//  Timeline
//
//  Created by Ilgar Ilyasov on 3/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol AudioCommentViewDelegate: class {
    func recordButtonTapped(on: UIView)
    func sendButtonTapped(on: UIView)
}

class AudioCommentView: UIView {
    
    var delegate: AudioCommentViewDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func record(_ sender: Any) {
        delegate?.recordButtonTapped(on: self)
    }
    
    @IBAction func send(_ sender: Any) {
        delegate?.sendButtonTapped(on: self)
    }
}
