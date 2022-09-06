//
//  SelectArticlesSectionViewController.swift
//  TestProject
//
//  Created by Богдан Стещенко on 03.09.2022.
//

import UIKit

class SelectArticlesSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Method
    func createArticles(titleButton: String?) {
        guard let titleButton = titleButton else { return }
        guard let popularArticlesViewController = PopularArticlesViewController(sectionTitle: titleButton) else { return }
        navigationController?.pushViewController(popularArticlesViewController, animated: true)
    }
    
    //MARK: - Action
    @IBAction func popularArticlesButton(_ sender: UIButton) {
        createArticles(titleButton: sender.titleLabel?.text)
    }
}
