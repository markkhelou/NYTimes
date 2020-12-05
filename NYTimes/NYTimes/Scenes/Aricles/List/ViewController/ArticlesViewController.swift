//
//  ViewController.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

protocol ArticlesDelegate: class {
    func reloadData()
    func showAlert(title: String?, message: String?)
}

class ArticlesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ArticlesViewModel {
        guard let viewModel = mainViewModel as? ArticlesViewModel else {
            fatalError("viewModel does not exist")
        }
        viewModel.delegate = self
        return viewModel
    }
    
    var refreshControl = UIRefreshControl()
    
    override func setupViews() {
        super.setupViews()
        setupNavigation()
        setupTableView()
        viewModel.getArticles()
    }
    
    
    private func setupNavigation() {
        title = NSLocalizedString("article.title", comment: "")
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "common/threedots"), style: .plain, target: self, action: #selector(dotsPressed)),
            UIBarButtonItem(image: UIImage(named: "common/search"), style: .plain, target: self, action: #selector(searchPressed))
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "common/menu"), style: .plain, target: self, action: #selector(menuPressed))
    }
    
    @objc func menuPressed() {
        //menu pressed
    }
    
    @objc func searchPressed() {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("search", comment: ""), style: .default, handler: { alert -> Void in
            guard let textField = alertController.textFields?.first else { return }
            self.viewModel.search(for: textField.text)
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = NSLocalizedString("search", comment: "")
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func dotsPressed() {
        //dots pressed
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
        viewModel.getArticles()
        refreshControl.endRefreshing()
    }
    
    private func articlePressed(at index: Int) {
        let model = viewModel.getArticleDetailsModel(at: index)
        let viewModel = ArticleDetailViewModel(model: model)
        let viewController = ArticleDetailViewController.create(with: "Articles",
                                                          viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier) as? ArticleTableViewCell else { fatalError() }
        let model = viewModel.getArticle(at: indexPath.row)
        cell.model = model
        return cell
    }
}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        articlePressed(at: indexPath.row)
    }
}

extension ArticlesViewController: ArticlesDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: NSLocalizedString("button.ok", comment: ""),
                                        style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
}
