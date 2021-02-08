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
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

        albumCoverName.text = "Text"
        
    }

}

extension SearchCollectionViewCell: ViewConfigurable {
    
    
    struct Model {
        let imageURL: URL?
        let title: String
    }
    
    func configurate(model: Model) {
        
        self.albumCoverImage.imgUrl = model.imageURL
        self.albumCoverName.text = model.title
    }
}
