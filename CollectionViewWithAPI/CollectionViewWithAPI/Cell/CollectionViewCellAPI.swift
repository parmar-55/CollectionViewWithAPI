//
//  CollectionViewCellAPI.swift
//  CollectionViewWithAPI
//
//  Created by Demo 01 on 19/05/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit

class CollectionViewCellAPI: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        image.image=nil
    }
    
    

}
