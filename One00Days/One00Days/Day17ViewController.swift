//
//  Day17ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/8/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day17ViewController: UIViewController {
  
  lazy var foldingView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    setupViewHierarchy()
    configureConstraints()
    self.foldingView.layer.addSublayer(drawFoldingLayers())
    
    let currentBounds: CGRect = self.foldingView.layer.bounds
    
    self.foldingView.layer.transform = CATransform3DIdentity
    self.foldingView.layer.anchorPoint = CGPointMake(0.5, 0.0)
    self.foldingView.layer.position = CGPointMake(0.0, -100.0)
    UIView.animateWithDuration(2.0, animations: { () -> Void in
      self.foldingView.layer.transform = CATransform3DMakeRotation(degreesToRadians(75.0), 1.0, 0.0, 0.0)
      }) { (complete: Bool) -> Void in
        
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    foldingView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(200.0, 200.0))
      make.center.equalTo(self.view.snp_center)
    }
    
    view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(foldingView)
  }
  
  internal func drawFoldingLayers() -> CALayer {
    let containerLayer: CALayer = CALayer()
    containerLayer.frame = self.foldingView.bounds
    
    let topPath: UIBezierPath = UIBezierPath(rect: CGRectMake(0.0, 0.0, 100.0, 100.0))
    let bottomPath: UIBezierPath = UIBezierPath(rect: CGRectMake(0.0, 100.0, 100.0, 100.0))
    
    let topLayer: CAShapeLayer = CAShapeLayer()
    topLayer.path = topPath.CGPath
    topLayer.strokeColor = UIColor.purpleColor().CGColor
    topLayer.fillColor = UIColor.redColor().CGColor
    topLayer.lineWidth = 3.0
    
    let bottomLayer: CAShapeLayer = CAShapeLayer()
    bottomLayer.path = bottomPath.CGPath
    bottomLayer.strokeColor = UIColor.blueColor().CGColor
    bottomLayer.fillColor = UIColor.redColor().CGColor
    bottomLayer.lineWidth = 3.0
    
    containerLayer.addSublayer(topLayer)
    containerLayer.addSublayer(bottomLayer)
    
    topPath.stroke()
    bottomPath.stroke()
    
    return containerLayer
  }
  
  internal func topFoldAnimation(layer: CALayer) {
    let fold: CATransform3D = CATransform3DMakeRotation(degreesToRadians(75.0), 1.0, 0.0, 0.0)
    layer.anchorPoint = CGPointMake(0.5, 0.0) // top middle
    
    layer.transform = CATransform3DIdentity
    UIView.animateWithDuration(3.0) { () -> Void in
      layer.transform = fold
    }
  }
  
}
