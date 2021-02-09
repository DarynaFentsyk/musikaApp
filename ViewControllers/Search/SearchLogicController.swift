//
//  SearchLogicController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 09.02.21.
//

import Foundation

protocol SearchLogicControllerProtocol: class {
    
    var view: SearchViewControllerProtocol? { get set }
    
    func test()
}

final class SearchLogicController: SearchLogicControllerProtocol {
    
    weak var view: SearchViewControllerProtocol?
    
    func test() {
        
    }
}
