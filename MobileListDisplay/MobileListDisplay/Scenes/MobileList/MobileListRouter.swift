//
//  MobileListRouter.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol MobileListRoutingLogic {
  func routeToDetailInfo(segue: UIStoryboardSegue?)
}

protocol MobileListDataPassing {
  var dataStore: MobileListDataStore? { get }
}

class MobileListRouter: NSObject, MobileListRoutingLogic, MobileListDataPassing {
  weak var viewController: MobileListViewController?
  var dataStore: MobileListDataStore?
  
  // MARK: Routing
  func routeToDetailInfo(segue: UIStoryboardSegue?) {
    guard let detailViewController = segue?.destination as? MobileDetailsViewController,
      let selectedMobile = dataStore?.selectedMobile else { return }
    passDataToDetail(destination: detailViewController, selectedMobile: selectedMobile)
  }
  
  func passDataToDetail(destination: MobileDetailsViewController, selectedMobile: Mobile) {
    destination.router?.dataStore?.selectedMobile = selectedMobile
  }
}

extension MobileListViewController {
  // MARK: Routing
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
}
