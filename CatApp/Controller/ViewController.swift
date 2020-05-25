//
//  ViewController.swift
//  CatApp
//
//  Created by Nik on 22.05.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController, BreedsManagerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var breedsManager = BreedsManager()
    
    var breeds: [BreedModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        breedsManager.delegate = self
        breedsManager.fetchBreeds()
    }


    
    func didUpdateBreeds(_ breedsManager: BreedsManager, breeds: [BreedModel]) {
        for breed in breeds{
        print(breed)
        }
        
    }
     
     func didFailWithError(error: Error) {
         print(error)
     }
    
    

}
