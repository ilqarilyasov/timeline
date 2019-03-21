//
//  CancelButtonView.swift
//  Timeline
//
//  Created by Ilgar Ilyasov on 3/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol CancelButtonViewDelegate: class {
    func cancelButtonTapped(on: UIView)
}

class CancelButtonView: UIView {

    weak var delegate: CancelButtonViewDelegate?
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.cancelButtonTapped(on: self)
    }
}
