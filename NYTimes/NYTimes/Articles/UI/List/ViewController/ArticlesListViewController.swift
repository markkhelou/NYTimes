//
//  ArticlesListViewController.swift
//  NYTimes
//
//  Created by marc helou on 2/18/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Combine
import UIKit

class ArticlesListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: ArticlesNavigator?
    var viewModel: ArticlesViewModelProtocol
    
    init(coordinator: ArticlesNavigator?, viewModel: ArticlesViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var refreshControl = UIRefreshControl()
    private var cancellables: [AnyCancellable] = []
    private var articlesList: [ArticleResultsModel] = []
    
    override func setupViews() {
        super.setupViews()
        setupNavigation()
        setupTableView()
        viewModel.requestArticles()
    }
    
    override func bind() {
        super.bind()
        viewModel.articlesStatePublisher.sink { [weak self] result in
            self?.render(result)
        }
        .store(in: &cancellables)
    }
    
    private func render(_ state: ArticlesState) {
        switch state {
        case .idle:
            refreshControl.endRefreshing()
            LoadingHUD.shared.hideLoader()
        case .loading:
            LoadingHUD.shared.showLoader()
        case .noResults:
            showAlert(title: nil, message: NSLocalizedString("noResults", comment: ""))
            articlesList = []
            tableView.reloadData()
        case .failure(let error):
            showAlert(title: nil, message: error.localizedDescription)
        case .success(let articles):
            articlesList = articles
            tableView.reloadData()
        }
    }
    
    private func setupNavigation() {
        title = NSLocalizedString("article.title", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "common/search"), style: .plain, target: self, action: #selector(searchPressed))
    }
    
    @objc func searchPressed() {
        coordinator?.showSearchAlert { [weak self] searchText in
            self?.viewModel.search(for: searchText)
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleTableViewCell.nib,
                           forCellReuseIdentifier: ArticleTableViewCell.identifier)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        viewModel.requestArticles()
    }
    
    func articlePressed(at index: Int) {
        
        let model = articlesList[index]
        coordinator?.showDetails(for: model)
    }
    
    func showAlert(title: String?, message: String?) {
        coordinator?.showAlert(title: title, message: message)
    }
}

extension ArticlesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier) as? ArticleTableViewCell else { fatalError() }
        cell.model = articlesList[indexPath.row]
        return cell
    }
}

extension ArticlesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        articlePressed(at: indexPath.row)
    }
}
