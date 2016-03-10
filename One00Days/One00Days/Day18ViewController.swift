//
//  Day18ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/9/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day18ViewController: UIViewController {
  
  lazy var foldingView: UIView = {
  let view: UIView = UIView()
  view.backgroundColor = ColorSwatch.sr_darkChalkGreen
  return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    setupViewHierarchy()
    configureConstraints()
    drawTransformLayerWithGrid()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
//    let timer: NSTimer = NSTimer(timeInterval: 3.0, target: self, selector: "", userInfo: nil, repeats: true)
//    NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func drawTransformLayerWithGrid() {
    let transformLayer: CATransformLayer = CATransformLayer()
    
    let drawPath: UIBezierPath = UIBezierPath(roundedRect: CGRectMake(0.0, 0.0, 100.0, 100.0), cornerRadius: 15.0)
    drawPath.moveToPoint(CGPointMake(0.0, 0.0))
    
    for i in 1...9 {
      drawPath.moveToPoint(CGPointMake(CGFloat(i) * 10.0, 0.0))
      drawPath.addLineToPoint(CGPointMake(CGFloat(i) * 10.0, 100.0))
      
      drawPath.moveToPoint(CGPointMake(0.0, CGFloat(i) * 10.0))
      drawPath.addLineToPoint(CGPointMake(100.0, CGFloat(i) * 10.0))
    }
    
    let perspectiveLayer: CAShapeLayer = CAShapeLayer()
    perspectiveLayer.path = drawPath.CGPath
    perspectiveLayer.strokeColor = ColorSwatch.sr_mintGreen.CGColor
    perspectiveLayer.fillColor = ColorSwatch.sr_coolWhite.CGColor
    perspectiveLayer.lineWidth = 3.0
    
//    drawPath.stroke()
    
    transformLayer.addSublayer(perspectiveLayer)
    
    var appliedTransform: CATransform3D = CATransform3DIdentity
    appliedTransform.m34 = -1.0
//    appliedTransform.m11 = -1.0
    appliedTransform.m12 = -1.0
    
    perspectiveLayer.anchorPoint = CGPointMake(1.0, 0.5)
    perspectiveLayer.transform = appliedTransform
    
    self.foldingView.layer.addSublayer(perspectiveLayer)
  }
  
  internal func configureConstraints() {
    self.foldingView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(250.0, 250.0))
      make.center.equalTo(self.view.snp_center)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.foldingView)
  }
  
}
