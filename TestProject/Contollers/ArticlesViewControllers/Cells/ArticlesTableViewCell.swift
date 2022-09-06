//
//  ArticlesTableViewCell.swift
//  TestProject
//
//  Created by Богдан Стещенко on 03.09.2022.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {
    
    private let articlesLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameArticlesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let dateArticlesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        articlesLogo.layer.cornerRadius = 20
        articlesLogo.contentMode = .scaleAspectFit
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConsrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addSubview(articlesLogo)
        self.addSubview(nameArticlesLabel)
        self.addSubview(dateArticlesLabel)
        
    }
    
    func configureArticlesCell(articles: Article) {
        nameArticlesLabel.text = articles.title
        dateArticlesLabel.text = articles.published_date
        getImage(urlString: articles.media?.first?.media_metadata[0].url)
    }
    
    private func getImage(urlString: String?) {
        guard let  urlString = urlString else {
            self.articlesLogo.image = UIImage(named: "default")
            return }
        guard let urlString = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            if let error = error {
                print("Error = \(error)")
            } else {
                guard let data = data else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.sync {
                    self.articlesLogo.image = image
                }
            }
        }.resume()
    }
    
    //MARK: - Constrains
    private func setConsrains() {
        NSLayoutConstraint.activate([
            articlesLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            articlesLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            articlesLogo.heightAnchor.constraint(equalToConstant: 75),
            articlesLogo.widthAnchor.constraint(equalToConstant: 75)
        ])
        NSLayoutConstraint.activate([
            nameArticlesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameArticlesLabel.leadingAnchor.constraint(equalTo: articlesLogo.trailingAnchor, constant: 10),
            nameArticlesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            dateArticlesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            dateArticlesLabel.widthAnchor.constraint(equalToConstant: 120),
            dateArticlesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
