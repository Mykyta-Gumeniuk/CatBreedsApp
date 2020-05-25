//
//  BreedData.swift
//  CatApp
//
//  Created by Nik on 24.05.2020.
//  Copyright © 2020 Mykyta Gumeniuk. All rights reserved.
//

import Foundation

struct BreedData: Decodable{
        let weight: Weight
        let id, name , description: String
    }

struct Weight: Decodable{
        let imperial, metric: String
    }

