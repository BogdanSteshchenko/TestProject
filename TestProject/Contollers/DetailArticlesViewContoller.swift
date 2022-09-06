//
//  DetailArticlesViewContoller.swift
//  TestProject
//
//  Created by Богдан Стещенко on 03.09.2022.
//

import UIKit

class DetailArticlesViewContoller: UIViewController {
    
    @IBOutlet weak var imageArticleLabel: UIImageView!
    @IBOutlet weak var titleArticleLabel: UILabel!
    @IBOutlet weak var sectionArticleLabel: UILabel!
    @IBOutlet weak var abstractArticleLabel: UILabel!
    @IBOutlet weak var bylineArticleLabel: UILabel!
    @IBOutlet weak var dateArticleLabel: UILabel!
    @IBOutlet weak var addArticleButton: UIButton!
    
    var article: Article?
    var favoriteArticle: ArticleFavorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if article != nil {
            setModel()
        } else {
            setModelFavorite()
        }

    }
    
    private func setModel() {
        guard let article = article else { return }

        titleArticleLabel.text = article.title
        sectionArticleLabel.text = article.section
        abstractArticleLabel.text = article.abstract
        bylineArticleLabel.text = article.byline
        dateArticleLabel.text = article.published_date
        
        if let image = self.getImage(urlString: article.media?.first?.media_metadata[2].url) {
            self.imageArticleLabel.image = image
        } else {
            self.imageArticleLabel.image = UIImage(named: "default")
        }
    }
    private func setModelFavorite() {
        addArticleButton.isHidden = true
        titleArticleLabel.text = favoriteArticle?.titleFavorite
        sectionArticleLabel.text = favoriteArticle?.sectionFavorite
        abstractArticleLabel.text = favoriteArticle?.abstractFavorite
        bylineArticleLabel.text = favoriteArticle?.bylineFavorite
        dateArticleLabel.text = favoriteArticle?.published_dateFavorite
        if let image = getImageForFavorite() {
            imageArticleLabel.image = image
        } else {
            self.imageArticleLabel.image = UIImage(named: "default")
        }
    }
    private func getImageForFavorite() -> UIImage? {
        guard let data = favoriteArticle?.urlFavorite else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    private func getImage(urlString: String?) -> UIImage? {
        do {
            guard let urlString = urlString else { return nil }
            guard let url = URL(string: urlString) else { return nil }
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            return image
        } catch {
            return nil
        }
    }
    
    @IBAction func addArticleTofavoriteButton(_ sender: UIButton) {
        guard let article = article else { return }
        WorkCoreDate.shared.createItem(article: article)
    }
}


