//
//  DetailsViewController.swift
//  CatApp
//
//  Created by Nik on 24.05.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageManager = ImageManager()
    
    var breedName: String?
    
    var breedDescription: String?
    
    var breedId: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = breedName
        descriptionLabel.text = breedDescription
        
        imageManager.delegate = self
        imageManager.fetchImage(breedId: breedId!, amount: 2)
    }
    
}

extension DetailsViewController: ImageManagerDelegate{
    func didUpdateImage(_ imageManager: ImageManager, images: [ImageModel]) {
        DispatchQueue.main.async {
            self.imageView.downloaded(from: images[0].url)
        }
    }
    
         
         func didFailWithError(error: Error) {
             print(error)
         }
    }

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
