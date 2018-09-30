//
//  MobileDetailsPresenterTest.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Quick
import Nimble

@testable import MobileListDisplay

class DetailPresenterTest: QuickSpec {
  
  override func spec() {
    
    var presenter: MobileDetailsPresenter!
    var viewController: MobileDetailsViewControllerSpy!
    
    beforeEach {
      presenter = MobileDetailsPresenter()
      viewController = MobileDetailsViewControllerSpy()
      presenter.viewController = viewController
    }
    
    describe("Display select data") {
      context("Should present correct data") {
        
        let mobile = Mobile()
        mobile.id = 1
        mobile.rating = 4.9
        mobile.name = "Moto E4 Plus"
        mobile.description = "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly."
        mobile.thumbImageURL = "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg"
        mobile.brand = "Samsung"
        mobile.price = 179.99
        
        let image1 = MobileDetailImages()
        image1.id = 1
        image1.mobileId = 1
        image1.url = "https://www.91-img.com/gallery_images_uploads/f/c/fc3fba717874d64cf15d30e77a16617a1e63cc0a.jpg"
        
        let image2 = MobileDetailImages()
        image2.id = 2
        image2.mobileId = 2
        image2.url = "https://www.91-img.com/gallery_images_uploads/f/c/fc3fba717874d64cf15d30e77a16617a1e63cc0b.jpg"
        
        let image3 = MobileDetailImages()
        image3.id = 3
        image3.mobileId = 3
        image3.url = "https://www.91-img.com/gallery_images_uploads/f/c/fc3fba717874d64cf15d30e77a16617a1e63cc0c.jpg"
        
        let imageGallery = [image1, image2, image3]
        
        it("Should display selected mobile data") {
          presenter.presentMobileDetails(response: MobileDetails.GetMobileDetail.Response(mobile: mobile, imageGallery: imageGallery))
          expect(viewController.mobileDetail?.mobile.name) == "Moto E4 Plus"
          expect(viewController.mobileDetail?.mobile.id) == 1
          expect(viewController.mobileDetail?.imageGallery).to(haveCount(3))
        }
      }
    }
    
  }
  
}


class MobileDetailsViewControllerSpy: MobileDetailsDisplayLogic {
  var mobileDetail: MobileDetails.GetMobileDetail.ViewModel.MobileDetail?

  func displayMobileDetail(viewModel: MobileDetails.GetMobileDetail.ViewModel) {
    mobileDetail = viewModel.mobileDetail
  }
  
  func displayMobileDetailError() {
    
  }
}
