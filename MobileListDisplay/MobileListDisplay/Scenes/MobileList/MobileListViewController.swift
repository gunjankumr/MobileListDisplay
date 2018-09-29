//
//  MobileListViewController.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SWSegmentedControl
import SVProgressHUD


protocol MobileListDisplayLogic: class {
  func displayMobileList(viewModel: MobileList.GetMobileList.ViewModel)
  func displayMobileListWithSorting(viewModel: MobileList.GetSortedMobileList.ViewModel)
  func displaySelectedMobile(viewModel: MobileList.SelectedMobile.ViewModel)

}

class MobileListViewController: UIViewController, MobileListDisplayLogic {
  
  var interactor: MobileListBusinessLogic?
  var router: (NSObjectProtocol & MobileListRoutingLogic & MobileListDataPassing)?
  var mobiles: [MobileList.MobileInfo] = []

  @IBOutlet weak var segmentedControl: SWSegmentedControl!
  @IBOutlet var tableView: UITableView!
  
  var sorting: Sorting = .low
  var selectedTab: TapOptions = .all
  
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
    getMobileDataFromService()
  }

  
    // MARK: - Display Functions
  func displayMobileList(viewModel: MobileList.GetMobileList.ViewModel) {
    SVProgressHUD.dismiss()
    switch viewModel.result {
    case .success:
      self.getMobileList()
    case .failure(.noInternet):
      self.showAlertWithMessage(title: "No Internet Connection", message: "Please check your internet connection.")
    case .failure(.serviceError):
      self.showAlertWithMessage(title: "Backend Issue", message: "Please try again later.")
    case .failure(.noRecord):
      self.showAlertWithMessage(title: "No Record", message: "No record found.")
    }
  }
  
  func displayMobileListWithSorting(viewModel: MobileList.GetSortedMobileList.ViewModel) {
    self.mobiles = viewModel.mobiles
    tableView.reloadData()
  }
  
  func displaySelectedMobile(viewModel: MobileList.SelectedMobile.ViewModel) {
    performSegue(withIdentifier: "DetailInfo", sender: nil)
  }
  
  // MARK: - Request Functions
  func getMobileDataFromService() {
    SVProgressHUD.show(withStatus: "Fetching Data...")
    let request = MobileList.GetMobileList.Request()
    interactor?.getMobileListFromService(request: request)
  }
  
  func getMobileList() {
    let request = MobileList.GetSortedMobileList.Request(selectedTab: selectedTab, sorting: sorting)
    interactor?.getSortedMobileList(request: request)
  }
  
  func selectedMobile(mobile: MobileList.MobileInfo) {
    let request = MobileList.SelectedMobile.Request(id: mobile.id)
    interactor?.selectedMobile(request: request)
  }

  
  @IBAction func buttonSortClick() {
    let alert = UIAlertController(title: "Sort",
                                  message: nil,
                                  preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "Price low to high",
                                  style: UIAlertAction.Style.default,
                                  handler: { action in
                                    self.sorting = .low
                                    self.getMobileList()
    }))
    
    alert.addAction(UIAlertAction(title: "Price high to low",
                                  style: UIAlertAction.Style.default,
                                  handler: { action in
                                    self.sorting = .high
                                    self.getMobileList()
    }))
    
    alert.addAction(UIAlertAction(title: "Rating",
                                  style: UIAlertAction.Style.default,
                                  handler: { action in
                                    self.sorting = .rating
                                    self.getMobileList()
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel",
                                  style: UIAlertAction.Style.cancel,
                                  handler: nil))
    
    self.present(alert, animated: true, completion: nil)
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
  
  
  @IBAction func segmentedChanged(_ sender: SWSegmentedControl) {
    print("select: \(sender.selectedSegmentIndex)")
    if sender.selectedSegmentIndex == 1 {
      selectedTab = .favourite
    } else {
      selectedTab = .all
    }
  }
  
}


// MARK: - Setup, Routing

extension MobileListViewController {
  
  fileprivate func setup() {
    let viewController = self
    let interactor = MobileListInteractor()
    let presenter = MobileListPresenter()
    let router = MobileListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
}
