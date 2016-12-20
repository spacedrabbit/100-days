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
  
  override func draw(_ rect: CGRect) {
//    let center: CGPoint = rect.midX*&rect.midY
    
//    let ctx = UIGraphicsGetCurrentContext()
//    let colorSpace = CGColorSpaceCreateDeviceRGB()
//    let gradient = CGGradient(colorsSpace: colorSpace, colors: [ColorSwatch.sr_mediumTeal.cgColor, ColorSwatch.sr_darkChalkGreen.cgColor], locations: [0.0, 1.0])
//    ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: 50.0, options: [])
  }
}


// ---------------------   TapTrackingViewDelegate   ------------------ //
protocol TapTrackingViewDelegate {
  func viewWasTapped(_ atPoint: CGPoint);
}

// ----------------------   TapTrackingView   ----------------------- //
class TapTrackingView: UIView {
  
  internal var tapTrackingDelegate: TapTrackingViewDelegate?
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
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
    self.tapView.snp.makeConstraints { (make) -> Void in
      make.left.right.centerY.equalTo(self.view)
      make.height.equalTo(300.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(tapView)
  }
  
  func viewWasTapped(_ atPoint: CGPoint) {
//    let centerPointInView: CGPoint = CGRectGetMidX(self.tapView.bounds)*&CGRectGetMidY(self.tapView.bounds)
    let initialRadius: CGFloat = 4.0
    let longestSideLength: CGFloat = fmax(self.tapView.bounds.width, self.tapView.bounds.height)
    let scaleFactor: CGFloat = longestSideLength / (initialRadius * 2)
    
    let path: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: atPoint.x - initialRadius, y: atPoint.y - initialRadius, width: initialRadius * 2, height: initialRadius * 2))
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = ColorSwatch.sr_hipsterBlueBlack.cgColor
    shapeLayer.strokeColor = shapeLayer.fillColor
    shapeLayer.frame = self.tapView.bounds
    
    let containerLayer: CALayer = CALayer()
    containerLayer.frame = self.tapView.bounds
    containerLayer.addSublayer(shapeLayer)
    
    var scaleTransform: CATransform3D = CATransform3DMakeScale(scaleFactor, scaleFactor, 1.0)
    scaleTransform.m34 = 1.0

    
    // to continue further try out what is listed in http://stackoverflow.com/questions/2981676/catransaction-layer-changes-but-does-not-animate
//      shapeLayer.transform = scaleTransform
      containerLayer.addSublayer(shapeLayer)
      self.tapView.layer.addSublayer(containerLayer)
//      self.tapView.layer.sublayerTransform = scaleTransform
//      self.tapView.layer.layoutSublayers()
  }
  
}
