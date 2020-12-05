//
//  file.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

class ArticlesViewModel: BaseViewModel {
    
    var articlesModelList: [ArticleTableViewCell.UIModel] = []
    var filteredArticlesModelList: [ArticleTableViewCell.UIModel] = []
    var articles: [ArticleResultsModel] = []
    weak var delegate: ArticlesDelegate?
    
    func getNumberOfRows() -> Int {
        return filteredArticlesModelList.count
    }
    
    func getArticle(at index: Int) -> ArticleTableViewCell.UIModel {
        return filteredArticlesModelList[index]
    }
    
    func getArticleDetailsModel(at index: Int) -> ArticleDetailModel {
        let articleModel = articles[index]
        // get the last image(best resolution)
        let detailModel = ArticleDetailModel(navigationTitle: articleModel.source,
                                             title: articleModel.title,
                                             byline: articleModel.byline,
                                             abstract: articleModel.abstract,
                                             imageURL: articleModel.media?.first?.mediaMetadata?.last?.url,
                                             caption: articleModel.media?.first?.caption,
                                             date: articleModel.published_date)
        return detailModel
    }
    
    func search(for text: String?) {
        if let text = text, !text.isEmpty {
            filteredArticlesModelList = articlesModelList.filter({
                ($0.title?.lowercased().contains(text.lowercased()) ?? false)
            })
        } else {
            filteredArticlesModelList = articlesModelList
        }
        delegate?.reloadData()
    }
    
    func getArticles() {
        LoadingHUD.shared.showLoader()
        ArticleRepository.shared.getArticles {[weak self] (result) in
            guard let self = self else { return }
            LoadingHUD.shared.hideLoader()
            switch result {
            case .success(let articles):
                if let articles = articles {
                    self.fillArticles(articles: articles.results)
                }
            case .failure:
                self.delegate?.showAlert(title: nil, message: NSLocalizedString("error.undefined", comment: ""))
            }
        }
    }
    
    func fillArticles(articles: [ArticleResultsModel]) {
        self.articles = articles
        self.articlesModelList = self.map(from: articles)
        self.filteredArticlesModelList = self.articlesModelList
        self.delegate?.reloadData()
    }
    
    func map(from response: [ArticleResultsModel]) -> [ArticleTableViewCell.UIModel] {
        return response.map { (article) -> ArticleTableViewCell.UIModel in
            return ArticleTableViewCell.UIModel(title: article.title,
                                                byline: article.byline,
                                                date: article.published_date,
                                                imageURLString: article.media?.first?.mediaMetadata?.first?.url)
        }
    }
}
