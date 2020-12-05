//
//  ArticleTableViewCell.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

extension ArticleTableViewCell {
    struct UIModel {
        var title: String?
        var byline: String?
        var date: String?
        var imageURLString: String?
    }
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: ImageViewFromURL!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var model: UIModel? {
        didSet {
            fillValue()
        }
    }
    
    private func fillValue() {
        guard let model = model else { return }
        titleLabel.text = model.title
        bylineLabel.text = model.byline
        dateLabel.text = model.date
        if let imageURLString = model.imageURLString {
            profileImageView.loadImage(imageURLString)
        } else {
            profileImageView.image = UIImage(named: "common/profile")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        profileImageView.circular()
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        bylineLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 12)
        
        bylineLabel.textColor = .gray
        dateLabel.textColor = .gray
    }
    
}
