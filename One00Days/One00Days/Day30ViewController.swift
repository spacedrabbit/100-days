//
//  Day30ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/21/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class CubicUnit: UIView {
  
  var sideLength: CGFloat = 0.0
  var matrixPosition: (Int, Int) = (0,0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  convenience init(withCubicSideLength length: CGFloat) {
    self.init(frame: CGRect.zero)
    self.sideLength = length
  }
  
  func setMatrixPosition(_ row: Int, column: Int) {
    self.matrixPosition = (row, column)
  }
  
}

class Day30ViewController: UIViewController {
  
  static let blockSize: CGFloat = 20.0
  var cubicGrid: [[CubicUnit]] = [[]]
  
  lazy var banner8BitView: UIView = {
  let view: UIView = UIView()
  view.backgroundColor = ColorSwatch.sr_mintGreen
  return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.setupGrid()
    
    self.addCubicsToView(self.banner8BitView)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func setupGrid() {
    let cubesByWidth: CGFloat = ceil(self.view.bounds.width / Day30ViewController.blockSize)
    let cubesByHeight: CGFloat = ceil(self.view.bounds.height / Day30ViewController.blockSize)
    
    var horizontal: [[CubicUnit]] = [[]]
    for horizontalCubics in 0...Int(cubesByWidth) {
      var vertical: [CubicUnit] = []
      for verticalCubics in 0...Int(cubesByHeight) {
        let newVertCubic: CubicUnit = CubicUnit(withCubicSideLength: Day30ViewController.blockSize)
        newVertCubic.setMatrixPosition(horizontalCubics, column: verticalCubics)
        newVertCubic.backgroundColor = ColorSwatch().randomColor()
        vertical.append(newVertCubic)
      }
      horizontal.append(vertical)
    }
    self.cubicGrid = horizontal
  }
  
  internal func addCubicsToView(_ view: UIView) {
    var currentOrigin: CGPoint = 0.0*&0.0
    
    for cubicRow: [CubicUnit] in self.cubicGrid {
      for cubic: CubicUnit in cubicRow {
        self.banner8BitView.addSubview(cubic)
        cubic.frame = CGRect(x: currentOrigin.x, y: currentOrigin.y, width: Day30ViewController.blockSize, height: Day30ViewController.blockSize)
        currentOrigin = CGPoint(x: currentOrigin.x + Day30ViewController.blockSize, y: currentOrigin.y)
      }
      currentOrigin = CGPoint(x: 0.0, y: currentOrigin.y + Day30ViewController.blockSize)
    }
  }
  
  internal func configureConstraints() {
    banner8BitView.snp.makeConstraints { (make) -> Void in
      make.left.right.centerY.equalTo(self.view)
      make.height.equalTo(240.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(banner8BitView)
  }
  
}
