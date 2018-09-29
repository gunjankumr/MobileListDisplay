//
//  MobileDetailsViewController.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright (c) 2018 Allianz Technology. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import iCarousel
import SVProgressHUD

protocol MobileDetailsDisplayLogic: class {
  func displayMobileDetail(viewModel: MobileDetails.GetMobileDetail.ViewModel)
  func displayMobileDetailError()
}

class MobileDetailsViewController: UIViewController, MobileDetailsDisplayLogic {
  var interactor: MobileDetailsBusinessLogic?
  var router: (NSObjectProtocol & MobileDetailsRoutingLogic & MobileDetailsDataPassing)?
  var mobileDetail: MobileDetails.GetMobileDetail.ViewModel.MobileDetail?
  
  @IBOutlet var imageGallery: iCarousel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var descLabel: UILabel!

  // MARK: Object Lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageGallery.delegate = self
    setUI()
    getMobileDetail()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    guard mobileDetail?.imageGallery != nil else { return}
      imageGallery.currentItemIndex = 0
  }
  
  func setUI() {
    self.title = router?.dataStore?.selectedMobile.name ?? "Detail"
    imageGallery.isPagingEnabled = true
  }
  
  func setDetail() {
    guard let mobile = mobileDetail?.mobile else { return }
    priceLabel.text = "$\(mobile.price)"
    ratingLabel.text = "\(mobile.rating)"
    descLabel.text = "\(mobile.description)\n\(mobile.description)"
  }
  
  //MARK: Request
  func getMobileDetail() {
    SVProgressHUD.show()
    let request = MobileDetails.GetMobileDetail.Request()
    interactor?.getMobileDetailInfo(request: request)
  }
  
  //MARK: Display
  func displayMobileDetail(viewModel: MobileDetails.GetMobileDetail.ViewModel) {
    SVProgressHUD.dismiss()
    mobileDetail = viewModel.mobileDetail
    setDetail()
    imageGallery.reloadData()
  }
  
  func displayMobileDetailError() {
    SVProgressHUD.dismiss()
    showAlertWithMessage(title: "Error", message: "Unable to fetch data")
  }
  
  func showAlertWithMessage(title: String, message: String) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "OK",
                                  style: UIAlertAction.Style.cancel,
                                  handler: nil))
    self.present(alert, animated: true, completion: nil)
  }

  
}

// MARK: - Setup, Routing

extension MobileDetailsViewController {
  
  fileprivate func setup() {
    let viewController = self
    let interactor = MobileDetailsInteractor()
    let presenter = MobileDetailsPresenter()
    let router = MobileDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
}
