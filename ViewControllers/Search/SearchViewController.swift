//
//  SearchViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 09.02.21.
//

import UIKit

protocol SearchViewControllerProtocol: class {
    
}

final class SearchViewController: UIViewController {
    
    private var logicController: SearchLogicControllerProtocol!
    
    static func make(logicController: SearchLogicControllerProtocol) -> SearchViewController {
        
        let viewController = SearchViewController()
        viewController.logicController = logicController
        logicController.view = viewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logicController.test()
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    
}
