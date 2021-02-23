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
        case .body: return .systemFont(ofSize: 12)
        case .headline: return .systemFont(ofSize: 14)
        }
    }
}
