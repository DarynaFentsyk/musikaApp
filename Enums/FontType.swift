//
//  FontType.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import UIKit

enum FontType {
    
    case body
    case headline
    
    var font: UIFont {
        switch self {
        case .body: return UIFont.systemFont(ofSize: 12)
        case .headline: return UIFont.systemFont(ofSize: 14)
        // case .body: return UIFont.preferredFont(forTextStyle: .body)
        // For dynamic preffered Font
        }
    }
}


