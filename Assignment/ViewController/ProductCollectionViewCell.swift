//
//  ProductCollectionViewCell.swift
//  Assignment
//
//  Created by Admin on 13/02/2022.
//  Copyright © 2022 Brain Plow. All rights reserved.
//

import UIKit
import Cosmos

class ProductCollectionViewCell: UICollectionViewCell {
   //MARK:- Outlets
  
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var productTitleLbl: UILabel!
  @IBOutlet weak var productPriceLbl: UILabel!
  @IBOutlet weak var buyBtn: UIButton!
  @IBOutlet weak var countLbl: UILabel!
  @IBOutlet weak var cosmosView: CosmosView!
  
}
