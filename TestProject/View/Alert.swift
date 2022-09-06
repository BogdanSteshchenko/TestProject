//
//  Alert.swift
//  TestProject
//
//  Created by Богдан Стещенко on 05.09.2022.
//

import UIKit

class Alert {
    
    static let shared = Alert()
    
    private init() {
    }
    
    func alertError(title: String, message: String, view: UIViewController) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let allrtOk = UIAlertAction(title: "Ок", style: .cancel)
        
        alertContoller.addAction(allrtOk)
        
        view.present(alertContoller, animated: true)
    }
}
