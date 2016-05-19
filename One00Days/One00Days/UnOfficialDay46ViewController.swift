//
//  UnOfficialDay46ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 5/18/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class UnOfficialDay46ViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  
  let allViewControllers: [UIViewController] = [Day32ViewController(), Day32ViewController(), Day32ViewController()]
  
  convenience init() {
    self.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    self.delegate = self
    self.dataSource = self
    
    if let firstViewController = allViewControllers.first {
      self.setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  internal func configureConstraints() {
    
  }
  
  internal func setupViewHierarchy() {
    
  }
  
  
  // MARK: - Delegate Methods
  func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
    print("There are \(pendingViewControllers) remaining")
  }
  
  func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    print("The prior view controllers were \(previousViewControllers)")
  }
 
  // MARK: - Datasource Methods
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = self.allViewControllers.indexOf(viewController) else {
      return nil
    }
    
    let previousIndex = currentIndex - 1
    guard previousIndex >= 0 else {
      print("previousIndex \(previousIndex) was less that or equal to zero")
      return nil
    }
    
    guard allViewControllers.count > previousIndex else {
      print("Count \(allViewControllers.count) was not greater than previous index \(previousIndex)")
      return nil
    }
    
    print("going to return \(allViewControllers[previousIndex]) as the previous VC")
    return allViewControllers[previousIndex]
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = self.allViewControllers.indexOf(viewController) else {
      print("Current Index of viewcontroller not found")
      return nil
    }
    
    let nextIndex = currentIndex + 1
    guard allViewControllers.count > nextIndex else {
      print("Next index \(nextIndex) was greater than view controller count \(allViewControllers.count)")
      return nil
    }
   
    print("going to return \(allViewControllers[nextIndex]) as the next VC")
    return allViewControllers[nextIndex]
  }
  
//  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//    return allViewControllers.count
//  }
//  
//  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//    guard let firstViewController = self.allViewControllers.first,
//      let firstViewControllerIndex = allViewControllers.indexOf(firstViewController) else {
//      return 0
//    }
//    
//    return firstViewControllerIndex
//  }
}
