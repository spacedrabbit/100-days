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
    let centerPointInView: CGPoint = CGRectGetMidX(self.tapView.bounds)*&CGRectGetMidY(self.tapView.bounds)
    let initialRadius: CGFloat = 4.0
    let longestSideLength: CGFloat = fmax(self.tapView.bounds.width, self.tapView.bounds.height)
    let scaleFactor: CGFloat = longestSideLength / (initialRadius * 2)
    
    let path: UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(centerPointInView.x - initialRadius, centerPointInView.y - initialRadius, initialRadius * 2, initialRadius * 2))
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = path.CGPath
    shapeLayer.fillColor = ColorSwatch.sr_hipsterBlueBlack.CGColor
    shapeLayer.strokeColor = shapeLayer.fillColor
    shapeLayer.frame = self.tapView.bounds
    
    print("scale factor: \(scaleFactor)")
    let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.fromValue = 1.0
    scaleAnimation.toValue = scaleFactor
    scaleAnimation.duration = 2.0
    scaleAnimation.removedOnCompletion = false
    
//    shapeLayer.addAnimation(scaleAnimation, forKey: "scale")
    
    
    let scaleTransform: CATransform3D = CATransform3DMakeScale(scaleFactor, scaleFactor, 1.0)
    shapeLayer.transform = scaleTransform
    UIView.animateKeyframesWithDuration(3.0, delay: 1.0, options: [], animations: { () -> Void in
      
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: { () -> Void in
        
        self.tapView.layer.addSublayer(shapeLayer)
        
      })
      
      }) { (complete: Bool) -> Void in
        
    }
  }
  
}
