//
//  TracksTableViewCell.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 16.02.21.
//

import UIKit

class TracksTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

}

extension TracksTableViewCell: ViewConfigurable {
    
    struct Model {
        let index: Int
        let title: String
        let duration: String
    }
    
    func configure(model: Model) {
        self.indexLabel.text = "\(model.index)."
        self.trackNameLabel.text = model.title
        self.durationLabel.text = Int(model.duration)?.secondsToTime() ?? ""
    }
    
    
    
}
