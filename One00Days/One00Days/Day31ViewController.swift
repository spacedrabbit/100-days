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
    var cubeGrid: CubicGrid = CubicGrid()
    
    let cubesByWidth: CGFloat = ceil(view.bounds.width / length)
    let cubesByHeight: CGFloat = ceil(view.bounds.height / length)
    
    for hCubics in 1...Int(cubesByHeight) {
      var cubicRow: [CubicUnit] = []
      for vCubics in 1...Int(cubesByWidth) {
        let newCubic: CubicUnit = CubicUnit(withCubicSideLength: length)
        newCubic.backgroundColor = ColorSwatch().randomColor()
        newCubic.setMatrixPosition(hCubics - 1, column: vCubics - 1)
        cubicRow.append(newCubic)
      }
      cubeGrid.append(cubicRow)
    }
    
    return cubeGrid
  }
  
  // the cubic grid should really be a class and not a typedef, it should contain instance properties
  class func addCubicGrid(grid: CubicGrid, toView view: UIView) {
    var currentOrigin: CGPoint = 0.0*&0.0
    
    for cubicRow: [CubicUnit] in grid {
      for cubic: CubicUnit in cubicRow {
        view.addSubview(cubic)
        cubic.frame = CGRectMake(currentOrigin.x, currentOrigin.y, Day30ViewController.blockSize, Day30ViewController.blockSize)
        currentOrigin = CGPointMake(currentOrigin.x + Day30ViewController.blockSize, currentOrigin.y)
      }
      currentOrigin = CGPointMake(0.0, currentOrigin.y + Day30ViewController.blockSize)
    }
  }
  
}

class Day31ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let grid: CubicGrid = CubicUnitManager.generateGridToFit(self.view, usingLength: 20.0)
    CubicUnitManager.addCubicGrid(grid, toView: self.view)
    
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
