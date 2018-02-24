//
//  ListCell.swift
//  Liverpool
//
//  Created by RanfeDom on 2/24/18.
//  Copyright © 2018 Ranfelabs. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ListCell: UITableViewCell {
  
  static let identifier = "cell"
  
  @IBOutlet weak var thumbImage: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var price: UILabel!
  
  func configureCell(_ model: ListViewModel) {
    title.text = model.title
    price.text = model.price
    let url = URL(string: model.imgURL)
    thumbImage.sd_setImage(with: url, completed: nil)
  }
}
