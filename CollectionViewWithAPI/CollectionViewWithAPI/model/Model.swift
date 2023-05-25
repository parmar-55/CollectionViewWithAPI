//
//  Model.swift
//  CollectionViewWithAPI
//
//  Created by Demo 01 on 19/05/23.
//  Copyright © 2023 scs. All rights reserved.
//

import Foundation


struct Product:Decodable {
    let id:Int
    let title:String
    let price:Float
    let description:String
    let category:String
    let image:String
    let rating:rate
}

struct rate:Decodable {
    let rate:Float
    let count:Int
}


