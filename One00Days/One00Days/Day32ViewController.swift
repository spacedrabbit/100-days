//
//  Day32ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/23/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

func ==(lhs: CubicGrid, rhs: CubicGrid) -> Bool {
  return false
}

typealias CubicGridSize = (rows: Int, columns: Int)

class CubicGrid: Equatable {
  var cubicSideLength: CGFloat = 0.0
  var cubicBackgroundColor: UIColor?
  var grid: [[CubicUnit]] = [[CubicUnit]]()
  
  
  init(withCubicSideLength length: CGFloat, initialColor color: UIColor? = ColorSwatch().randomColor()) {
    self.cubicSideLength = length
    self.cubicBackgroundColor = color
  }
  
  private func gridSizeForView(view: UIView) -> CubicGridSize {
    let cubesByWidth: CGFloat = ceil(view.bounds.width / self.cubicSideLength)
    let cubesByHeight: CGFloat = ceil(view.bounds.height / self.cubicSideLength)
    
    return (rows: Int(cubesByWidth), columns: Int(cubesByHeight))
  }
  
  
  func createGridForView(view: UIView) -> CubicGrid{
    let (rows, columns) = self.gridSizeForView(view)
    
    var tempGrid = [[CubicUnit]]()
    for vCubics in 1...columns {
      var cubicRow = [CubicUnit]()
      for hCubics in 1...rows {
        let newCubic: CubicUnit = CubicUnit(withCubicSideLength: self.cubicSideLength)
        newCubic.backgroundColor = self.cubicBackgroundColor ?? ColorSwatch().randomColor()
        newCubic.setMatrixPosition(hCubics - 1, column: vCubics - 1)
        cubicRow.append(newCubic)
      }
      tempGrid.append(cubicRow)
    }
    
    self.grid = tempGrid
    return self // returns self because I wanted a 1 liner
  }
  
  func drawGridInView(view: UIView) -> CubicGrid {
    var currentOrigin: CGPoint = 0.0*&0.0
    
    for cubicRow: [CubicUnit] in self.grid {
      for cubic: CubicUnit in cubicRow {
        view.addSubview(cubic)
        cubic.frame = CGRectMake(currentOrigin.x, currentOrigin.y, Day30ViewController.blockSize, Day30ViewController.blockSize)
        currentOrigin = CGPointMake(currentOrigin.x + Day30ViewController.blockSize, currentOrigin.y)
      }
      currentOrigin = CGPointMake(0.0, currentOrigin.y + Day30ViewController.blockSize)
    }

    return self
  }
  
  
}

class Day32ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    CubicUnitManager.generateGridToFit(self.view, usingLength: 20.0)
    
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
