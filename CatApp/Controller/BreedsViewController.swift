//
//  ViewController.swift
//  CatApp
//
//  Created by Nik on 24.05.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var breedsManager = BreedsManager()
    
    var breeds: [BreedModel] = []
    
    var cellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        breedsManager.delegate = self
        breedsManager.fetchBreeds()
    }

}
    
  
extension BreedsViewController: BreedsManagerDelegate{
    
      func didUpdateBreeds(_ breedsManager: BreedsManager, breeds: [BreedModel]) {
        self.breeds = breeds
        for breed in breeds{
            print(breed)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        
        }
         
         func didFailWithError(error: Error) {
             print(error)
         }
    }

extension BreedsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = breeds[indexPath.row].name
        return cell
    }
}

extension BreedsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        cellIndex = indexPath.row
        self.performSegue(withIdentifier: "ListToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListToDetails"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.breedName = breeds[cellIndex].name
            destinationVC.breedDescription = breeds[cellIndex].description
            destinationVC.breedId = breeds[cellIndex].id
        }
    }
}

