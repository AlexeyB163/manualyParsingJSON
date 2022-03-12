//
//  ViewController.swift
//  manualyParsingJSON
//
//  Created by User on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {

    
    let url = "https://randomuser.me/api/"
       
    override func viewDidLoad() {
        super.viewDidLoad()
             
        getRandomUser()

    }
    
    private func getRandomUser() {
        NetworkManager.shared.fetchData(url: url) { result in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print(error)
            }
        }
    }
}

