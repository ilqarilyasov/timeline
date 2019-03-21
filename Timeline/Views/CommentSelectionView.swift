//
//  CommentSelectionView.swift
//  Timeline
//
//  Created by Ilgar Ilyasov on 3/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol CommentSelectionViewDelegate: class {
    func selectTextTapped(on view: UIView)
    func selectAudioTapped(on view: UIView)
}

class CommentSelectionView: UIView {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    weak var delegate: CommentSelectionViewDelegate?
    
    @IBAction func selectText(_ sender: Any) {
        delegate?.selectTextTapped(on: self)
    }
    
    @IBAction func selectAudio(_ sender: Any) {
        delegate?.selectAudioTapped(on: self)
    }
}
