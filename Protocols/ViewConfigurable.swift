//
//  ViewConfigurable.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import UIKit

protocol ViewConfigurable: UIView {
    
    associatedtype Model
    
    func configure(model: Model)
}
