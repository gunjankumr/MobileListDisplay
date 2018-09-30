//
//  MobileDetail+ImageGallery.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import UIKit
import iCarousel
import SDWebImage

extension MobileDetailsViewController: iCarouselDataSource {
  func numberOfItems(in carousel: iCarousel) -> Int {
    guard let count = mobileDetail?.imageGallery.count else { return 0 }
    return count
  }
  
  func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
    let imageSize = carousel.frame.size.height
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
    imageView.contentMode = .scaleAspectFit
    guard let imageData = mobileDetail?.imageGallery[index] else {
      return imageView
    }
    
    if !imageData.url.hasPrefix("http") { //Fix for unsupport url
      let urlWithHttp = "http://\(imageData.url)"
      imageView.sd_setImage(with: URL(string: urlWithHttp),
                            placeholderImage: UIImage(named: "defaultMobile"),
                            options: SDWebImageOptions.retryFailed,
                            completed: nil)
      
    } else {
      imageView.sd_setImage(with: URL(string: imageData.url),
                            placeholderImage: UIImage(named: "defaultMobile"),
                            options: SDWebImageOptions.retryFailed,
                            completed: nil)
    }
    
    return imageView
  }
  
  
}

extension MobileDetailsViewController: iCarouselDelegate {
  
  func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
    if (option == .spacing) {
      return value * 1.1
    }
    return value
  }
}


