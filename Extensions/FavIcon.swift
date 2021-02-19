//
//  FavIcon.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 15.02.21.
//


import UIKit

extension UIImage {
    
    class func favIcon(isFav: Bool) -> UIImage? {
        
        let saveIcon = UIImage(systemName: "plus")
        let delIcon  = UIImage(systemName: "trash")
        return isFav ? delIcon : saveIcon
    }
}
