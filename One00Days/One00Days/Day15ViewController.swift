//
//  Day15ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/6/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day15ViewController: UIViewController {
  
  lazy var cubeView: UIView = {
    let view: UIView = UIView(frame: CGRectZero)
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  lazy var hexGenerator: HexCube = {
    let hex: HexCube = HexCube()
    return hex
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    setupViewHierarchy()
    configureConstraints()
    hexItUp()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  internal func hexItUp() {
    let colorPalette: HexColors = (ColorSwatch.sr_coolWhite, ColorSwatch.sr_darkChalkGreen, ColorSwatch.sr_mintGreen)
    let prismPalette: PrismColors = (ColorSwatch.sr_darkTeal, ColorSwatch.sr_mediumTeal, ColorSwatch.sr_coolWhite)
    let cubeOriginPoint: CGPoint = CGPointMake(CGRectGetMidX(self.cubeView.bounds), CGRectGetMidY(self.cubeView.bounds))
    let cubeRadius: CGFloat = CGRectGetWidth(self.cubeView.frame) / 2.0
    
    self.hexGenerator.vertexPointsForHexCube(withOrigin: cubeOriginPoint, radius: cubeRadius)
    self.hexGenerator.drawHexCube(inView: self.cubeView, colors: colorPalette)
    self.hexGenerator.drawPrismOnCube(inView: self.cubeView, colors: prismPalette)
  }
  
  internal func configureConstraints() {
    self.cubeView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(200, 200))
      make.center.equalTo(self.view.snp_center)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(cubeView)
  }
  
}
