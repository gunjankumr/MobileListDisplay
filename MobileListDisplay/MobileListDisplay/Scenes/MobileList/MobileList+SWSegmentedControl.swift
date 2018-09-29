//
//  MobileList+SWSegmentedControl.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import SWSegmentedControl

extension MobileListViewController: SWSegmentedControlDelegate {
  // MARK: - SWSegmentedControlDelegate
  func segmentedControl(_ control: SWSegmentedControl, willSelectItemAtIndex index: Int) {
    print("will select \(index)")
  }
  
  func segmentedControl(_ control: SWSegmentedControl, didSelectItemAtIndex index: Int) {
    print("did select \(index)")
    if index == 1 {
      selectedTab = .favourite
    } else {
      selectedTab = .all
    }
  }
  
  func segmentedControl(_ control: SWSegmentedControl, willDeselectItemAtIndex index: Int) {
    print("will deselect \(index)")
  }
  
  func segmentedControl(_ control: SWSegmentedControl, didDeselectItemAtIndex index: Int) {
    print("did deselect \(index)")
  }
  
  func segmentedControl(_ control: SWSegmentedControl, canSelectItemAtIndex index: Int) -> Bool {
    if index == 1 {
      return false
    }
    
    return true
  }
}

