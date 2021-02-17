//
//  PlaceholderImageView.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import UIKit
import AlamofireImage

class PlaceholderImageView: UIImageView {
    
    var imgUrl: URL? {
        didSet {
            
            if let imgUrl = self.imgUrl {
                self.af.setImage(withURL: imgUrl, placeholderImage: #imageLiteral(resourceName: "AlbumPhoto"))
            } else {
                self.image = #imageLiteral(resourceName: "AlbumPhoto")
            }
        }
    }
}
