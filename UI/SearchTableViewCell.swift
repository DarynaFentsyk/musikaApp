//
//  SearchTableViewCell.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 10.02.21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistPhoto: PlaceholderImageView!
    @IBOutlet weak var artistName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SearchTableViewCell: ViewConfigurable {
    
    struct Model {
        let imageURL: URL?
        let title: String
    }
    
    func configure(model: Model) {
        
        self.artistPhoto.imgUrl = model.imageURL
        self.artistName.text = model.title
    }
    
    
    
    
    
}