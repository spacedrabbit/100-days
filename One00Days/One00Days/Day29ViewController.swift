//
//  Day29ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/20/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

// ----------------------   GradientView   ------------------- //
class GradientView: UIView {
  
//  override class func layerClass() -> AnyClass {
//    return CATransformLayer.self
//  }
  
  override func drawRect(rect: CGRect) {
    let center: CGPoint = CGRectGetMidX(rect)*&CGRectGetMidY(rect)
    
    let ctx = UIGraphicsGetCurrentContext()
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradientCreateWithColors(colorSpace, [ColorSwatch.sr_mediumTeal.CGColor, ColorSwatch.sr_darkChalkGreen.CGColor], [0.0, 1.0])
    CGContextDrawRadialGradient(ctx, gradient, center, 0.0, center, 50.0, [])
  }
}


// ---------------------   TapTrackingViewDelegate   ------------------ //
protocol TapTrackingViewDelegate {
  func viewWasTapped(atPoint: CGPoint);
}

// ----------------------   TapTrackingView   ----------------------- //
class TapTrackingView: UIView {
  
  internal var tapTrackingDelegate: TapTrackingViewDelegate?
  
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, withEvent: event)
    if hitView == self {
      self.tapTrackingDelegate?.viewWasTapped(point)
      return self
    }
    
    return nil
  }
  
}


// --------------------------------------------- //
class Day29ViewController: UIViewController, TapTrackingViewDelegate {
  
  lazy var tapView: TapTrackingView = {
  let view: TapTrackingView = TapTrackingView()
  view.backgroundColor = ColorSwatch.sr_hipsterAvocado
  view.tapTrackingDelegate = self
  return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func configureConstraints() {
    self.tapView.snp_makeConstraints { (make) -> Void in
      make.left.right.centerY.equalTo(self.view)
      make.height.equalTo(300.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(tapView)
  }
  
  func viewWasTapped(atPoint: CGPoint) {
//    let centerPointInView: CGPoint = CGRectGetMidX(self.tapView.bounds)*&CGRectGetMidY(self.tapView.bounds)
    let initialRadius: CGFloat = 4.0
    let longestSideLength: CGFloat = fmax(self.tapView.bounds.width, self.tapView.bounds.height)
    let scaleFactor: CGFloat = longestSideLength / (initialRadius * 2)
    
    let path: UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(atPoint.x - initialRadius, atPoint.y - initialRadius, initialRadius * 2, initialRadius * 2))
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = path.CGPath
    shapeLayer.fillColor = ColorSwatch.sr_hipsterBlueBlack.CGColor
    shapeLayer.strokeColor = shapeLayer.fillColor
    shapeLayer.frame = self.tapView.bounds
    
    let containerLayer: CALayer = CALayer()
    containerLayer.frame = self.tapView.bounds
    containerLayer.addSublayer(shapeLayer)
    
    var scaleTransform: CATransform3D = CATransform3DMakeScale(scaleFactor, scaleFactor, 1.0)
    scaleTransform.m34 = 1.0

//      shapeLayer.transform = scaleTransform
      containerLayer.addSublayer(shapeLayer)
      self.tapView.layer.addSublayer(containerLayer)
//      self.tapView.layer.sublayerTransform = scaleTransform
//      self.tapView.layer.layoutSublayers()
  }
  
}
