//
//  BreedsManager.swift
//  CatApp
//
//  Created by Nik on 24.05.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import Foundation

protocol BreedsManagerDelegate {
    func didUpdateBreeds(_ breedsManager: BreedsManager, breeds: [BreedModel])
    func didFailWithError(error: Error)
}

struct BreedsManager {

    let breedsURL = "https://api.thecatapi.com/v1/breeds?api_key=8322370e-bfef-4c99-89e3-e77dc82c1db9"
    
    var delegate: BreedsManagerDelegate?
    
    func fetchBreeds() {
        print("reqeusting")
        performRequest(with: breedsURL)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let breeds = self.parseJSON(safeData) {
                        self.delegate?.didUpdateBreeds(self, breeds: breeds)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ breedData: Data) -> [BreedModel]? {
        print("parsing")
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([BreedData].self, from: breedData)
            var breeds: [BreedModel] = []
            for breed in decodedData{
                let id = breed.id
                let name = breed.name
                let description = breed.description
                let nextBreed = BreedModel(id:id, name: name, description: description )
                breeds.append(nextBreed)
            }
            return breeds
        } catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
    
    
    
}


