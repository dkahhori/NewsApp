//
//  ViewController.swift
//  NewsApp
//
//  Created by Dilshodi Kahori on 6/19/22.
//

import UIKit
import Kingfisher

class NewsMainPageViewController: UIViewController {
    
    private let searchController = UISearchController()
    private var news: [News.NewsDetails] = []
    private var filteredNews = [News.NewsDetails]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupSearchController()
        parseJSON()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search News"
    }
    
    private func parseJSON() {
        let apiURL = //MARK: - ENTER HERE YOUR URL & APIKEY

        guard let url = URL(string: apiURL) else {return}
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            guard let data = data else {return}
            do {
                let parsingNews = try jsonDecoder.decode(News.self, from: data)
                DispatchQueue.main.async {
                    self.news = parsingNews.articles!
                    self.tableView.reloadData()
                    print("Success")
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

extension NewsMainPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FullNewsViewController()
        if isFiltering {
            vc.receivingURL = filteredNews[indexPath.row].url
        } else {
            vc.receivingURL = news[indexPath.row].url
        }
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension NewsMainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredNews.count
        } else {
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        var theNews: News.NewsDetails
        
        if isFiltering {
            theNews = filteredNews[indexPath.row]
        } else {
            theNews = news[indexPath.row]
        }
        
        cell.titleLabel.text = theNews.title
        cell.contentLabel.text = theNews.description
        let url = URL(string: theNews.image!)
        cell.imageContainerView.kf.setImage(with: url)
        return cell
    }
}

extension NewsMainPageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterNews(searchController.searchBar.text!)
    }
    
    private func filterNews(_ searchText: String) {
        filteredNews = news.filter({ (news: News.NewsDetails) -> Bool in
            return (news.title?.lowercased().contains(searchText.lowercased()))!
        })
        self.tableView.reloadData()
    }
}

