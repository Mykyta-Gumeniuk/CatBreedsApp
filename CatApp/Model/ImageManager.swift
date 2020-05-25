//
//  ImageManager.swift
//  CatApp
//
//  Created by Nik on 24.05.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import Foundation

protocol ImageManagerDelegate {
    func didUpdateImage(_ imageManager: ImageManager, images: [ImageModel])
    func didFailWithError(error: Error)
}

struct ImageManager {

    let imageURL = "https://api.thecatapi.com/v1/images/search?include_breeds=true&api_key=8322370e-bfef-4c99-89e3-e77dc82c1db9"
    
    var delegate: ImageManagerDelegate?
    
    func fetchImage(breedId: String, amount: Int) {
        print("reqeusting")
        let urlString = "\(imageURL)&breed_ids=\(breedId)&limit=\(amount)"
        print(urlString)
        performRequest(with: urlString)
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
                    if let images = self.parseJSON(safeData) {
                        self.delegate?.didUpdateImage(self, images: images)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ imageData: Data) -> [ImageModel]? {
        print("parsing")
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([ImageModel].self, from: imageData)
            print("decoded")
            var images: [ImageModel] = []
            for image in decodedData{
                let url = image.url
                let nextImage = ImageModel(url: url)
                images.append(nextImage)
            }
            
            return images
        } catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}


