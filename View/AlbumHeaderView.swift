//
//  AlbumHeaderView.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 16.02.21.
//

import UIKit

class AlbumHeaderView: UIView {
    
    @IBOutlet private weak var horizontalStackView: UIStackView!
    @IBOutlet private weak var imageView: PlaceholderImageView!
    @IBOutlet private weak var albumTitle: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    
    static func make() -> AlbumHeaderView {
        guard let view = Bundle.main.loadNibNamed("AlbumHeaderView", owner: nil, options: nil)?.first as? AlbumHeaderView  else {
            fatalError("UIView isn't in main bundle")

        }
        return view
    }
    
    var viewHeight: CGFloat{
        
        let screenWidth = UIScreen.main.bounds.width
        let arrangedSubview = horizontalStackView.arrangedSubviews.count
        let spacingCount = horizontalStackView.arrangedSubviews.count > 1 ? horizontalStackView.arrangedSubviews.count - 1 : 0
        let horizontalPadding = leadingConstraint.constant + trailingConstraint.constant + (horizontalStackView.spacing * CGFloat(spacingCount))
        let imageWidth  = (screenWidth - horizontalPadding) / CGFloat(arrangedSubview)
        let finalHeight = imageWidth + topConstraint.constant + bottomConstraint.constant
        
        return finalHeight
    }
}

extension AlbumHeaderView: ViewConfigurable {
    
    struct Model {
        
        let imageUrl: URL?
        let artistName: String
        let albumName: String
    }
    
    func configure(model: Model) {
        
        self.albumTitle.text = model.albumName
        self.artistLabel.text = model.artistName
        self.imageView.imgUrl = model.imageUrl
    }
}


