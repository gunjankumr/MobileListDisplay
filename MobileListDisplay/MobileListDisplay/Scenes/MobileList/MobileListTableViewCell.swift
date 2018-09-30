//
//  MobileListTableViewCell.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import UIKit
import SDWebImage

class MobileListTableViewCell: UITableViewCell {
  @IBOutlet var mobileImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var descLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var favButton: UIButton!

  func setMobile(mobile: MobileList.MobileInfo, selectedTab: TapOptions) {
    mobileImageView?.sd_setImage(with: URL(string: mobile.thumbImageURL),
                              placeholderImage: UIImage(named: "defaultMobile"),
                              options: .refreshCached,
                              completed: nil)
    
    nameLabel.text = mobile.name
    descLabel.text = mobile.description
    ratingLabel.text = "\(mobile.rating)"
    priceLabel.text = "$\(mobile.price)"
    
    if selectedTab == .favourite {
      favButton.isHidden = true
    } else {
      favButton.isHidden = false
    }
    
    if FavouriteListWorker.shared.getIsFavouriteById(mobileId: mobile.id) {
      favButton.setImage(UIImage(named: "fav_selected"), for: .normal)
    } else {
      favButton.setImage(UIImage(named: "fav"), for: .normal)
    }

  }
}
