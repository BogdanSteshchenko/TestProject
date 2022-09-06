//
//  WorkCoreDate.swift
//  TestProject
//
//  Created by Богдан Стещенко on 04.09.2022.
//

import UIKit
import CoreData

class WorkCoreDate {
    
    static let shared = WorkCoreDate()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {
    }
    
    func createItem(article: Article) {
        let allArticle = try? context.fetch(ArticleFavorite.fetchRequest())
        var flag = false
        if allArticle != [] {
            for index in 0...allArticle!.count - 1 {
                if article.title == allArticle?[index].titleFavorite  {
                    flag = true
                    break
                } else {
                    flag = false
                }
            }
            if flag {
                return
            } else {
                self.createArticle(article: article)
                flag = false
            }
        } else {
            self.createArticle(article: article)
        }
    }

    func createArticle(article: Article) {
        let newArticle = ArticleFavorite(context: context)
        newArticle.titleFavorite = article.title
        newArticle.published_dateFavorite = article.published_date
        newArticle.sectionFavorite = article.section
        newArticle.bylineFavorite = article.byline
        newArticle.abstractFavorite = article.abstract
        
        if let dataImage = fromJpegToData(urlString: article.media?.first?.media_metadata[2].url) {
            newArticle.urlFavorite = dataImage
        }
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func getAllOfflineArticles(responce: @escaping ([ArticleFavorite]?, Error?) -> Void) {
        do {
           let article = try context.fetch(ArticleFavorite.fetchRequest())
            responce(article, nil)
        } catch {
            responce(nil, NSError())
        }
    }
    
    func deleteItem(article: ArticleFavorite, responce: @escaping ([ArticleFavorite]?, Error?) -> Void) {
        context.delete(article as NSManagedObject)
        let fetchRequest: NSFetchRequest<ArticleFavorite> = ArticleFavorite.fetchRequest()
        do {
            try context.save()
            let article = try context.fetch(fetchRequest)
            responce(article, nil)
        } catch {
            responce(nil, NSError())
        }
    }
    
    private func fromJpegToData(urlString: String?) -> Data? {
        do {
            guard let urlString = urlString else { return nil }
            guard let url = URL(string: urlString) else { return nil }
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            guard let imageData = image?.jpegData(compressionQuality: 1.0) else { return nil }
            return imageData
        } catch {
            return nil
        }
    }
}
