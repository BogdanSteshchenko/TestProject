//
//  FavoritesArticlesTableViewController.swift
//  TestProject
//
//  Created by Богдан Стещенко on 04.09.2022.
//

import UIKit
import CoreData

class FavoritesArticlesTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var article = [ArticleFavorite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllOfflineArticles()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFavorite", for: indexPath) as! FavoritesArticlesTableViewCell
        let article = self.article[indexPath.row]
        cell.configureArticlesCell(articles: article)

        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteArticle(article: article[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailArticlesViewContoller = storyboard.instantiateViewController(withIdentifier: "articlesDetail") as! DetailArticlesViewContoller
        let article = article[indexPath.row]
        detailArticlesViewContoller.favoriteArticle = article
        navigationController?.pushViewController(detailArticlesViewContoller, animated: true)
    }
}

//MARK: - Method
extension FavoritesArticlesTableViewController {
    
    func getAllOfflineArticles() {
        WorkCoreDate.shared.getAllOfflineArticles { article, error in
            if let error = error {
                print("ERROR = \(error)")
            } else if let article = article {
                self.article = article
                self.tableView.reloadData()
            }
        }
    }
    func deleteArticle(article: ArticleFavorite) {
        WorkCoreDate.shared.deleteItem(article: article) { article, error in
            if let error = error {
                print("ERROR = \(error)")
            } else if let article = article {
                self.article = article
                self.tableView.reloadData()
                self.tableView.reloadData()
            }
        }
    }
}
