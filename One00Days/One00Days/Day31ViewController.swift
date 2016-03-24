//
//  Day31ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/22/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class CubicUnitManager {
  
  static let manager: CubicUnitManager = CubicUnitManager()
  
  class func generateGridToFit(view: UIView, usingLength length: CGFloat) -> CubicGrid {
    let cubicGrid: CubicGrid = CubicGrid(withCubicSideLength: length).createGridForView(view).drawGridInView(view)
    return cubicGrid
  }
  
  
}


class Day31ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let grid: CubicGrid = CubicUnitManager.generateGridToFit(self.view, usingLength: 20.0)
//    CubicUnitManager.addCubicGrid(grid, toView: self.view)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    
  }
  
  internal func setupViewHierarchy() {
    
  }
  
}
