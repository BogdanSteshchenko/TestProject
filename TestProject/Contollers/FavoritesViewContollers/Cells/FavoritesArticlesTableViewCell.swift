//
//  FavoritesArticlesTableViewCell.swift
//  TestProject
//
//  Created by Богдан Стещенко on 04.09.2022.
//

import UIKit

class FavoritesArticlesTableViewCell: UITableViewCell {
    //MARK: - Outlet
    @IBOutlet weak var articlesLogo: UIImageView!
    @IBOutlet weak var nameArticlesLabel: UILabel!
    @IBOutlet weak var dateArticlesLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        articlesLogo.layer.cornerRadius = 20
    }

    //MARK: - Method
    func configureArticlesCell(articles: ArticleFavorite) {
        nameArticlesLabel.text = articles.titleFavorite
        dateArticlesLabel.text = articles.published_dateFavorite
        if let image = self.getImage(imageData: articles.urlFavorite) {
            self.articlesLogo.image = image
        } else {
            self.articlesLogo.image = UIImage(named: "default")
        }
    }
    
    private func getImage(imageData: Data?) -> UIImage? {
        guard let imageData = imageData else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
}
