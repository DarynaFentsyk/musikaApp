//
//  SearchCollectionViewCell.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 03.02.21.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumCoverImage: PlaceholderImageView!
    @IBOutlet weak var albumCoverName: UILabel!
}

extension SearchCollectionViewCell: ViewConfigurable {
    
    struct Model {
        
        let imageURL: URL?
        let title: String
    }
    
    func configure(model: Model) {
        
        self.albumCoverImage.imgUrl = model.imageURL
        self.albumCoverName.text = model.title
    }
}
