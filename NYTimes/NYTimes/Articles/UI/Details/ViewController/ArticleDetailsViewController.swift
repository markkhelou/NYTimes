//
//  ArticleDetailsViewController.swift
//  NYTimes
//
//  Created by marc helou on 2/18/21.
//  Copyright © 2021 marc helou. All rights reserved.
//
import UIKit

class ArticleDetailsViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var profileImageView: ImageViewFromURL!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
        
    var model: ArticleDetailModel
    
    init(model: ArticleDetailModel) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        titleLabel.font = .boldSystemFont(ofSize: 24)
        abstractLabel.font = .systemFont(ofSize: 14)
        bylineLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 13)
        captionLabel.font = .boldSystemFont(ofSize: 12)
        
        bylineLabel.textColor = .gray
        dateLabel.textColor = .gray
        captionLabel.textColor = .lightGray
        abstractLabel.textColor = .darkGray
        profileImageView.maskCorners(8)
    }
    
    override func setupContentData() {
        super.setupContentData()
        fillData()
    }
    
    private func fillData() {
        title = model.navigationTitle
        titleLabel.text = model.title
        bylineLabel.text = model.byline
        abstractLabel.text = model.abstract
        captionLabel.text = model.caption
        dateLabel.text = model.date
        if let urlString = model.imageURL {
            profileImageView.loadImage(urlString)
        } else {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = UIImage(named: "common/profile")
        }
    }
}
