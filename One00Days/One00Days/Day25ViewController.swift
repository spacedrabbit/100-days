//
//  Day25ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/16/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day25ViewController: UIViewController {
  lazy var circularGradientView: UIView = {
  let view: UIView = UIView()
    view.backgroundColor = ColorSwatch.sr_mediumTeal
  return view
  }()
  
  
  lazy var gView: GradientView = {
  let view: GradientView = GradientView()
  
  return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func configureConstraints() {
    circularGradientView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(180.0+&180.0)
    }
    
    gView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.circularGradientView)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func drawRadialGradient() {
    let center: CGPoint = CGRectGetMidX(self.circularGradientView.bounds)*&CGRectGetMidY(self.circularGradientView.bounds)
    let endPoint: CGPoint = CGRectGetMaxX(self.circularGradientView.bounds)*&CGRectGetMaxY(self.circularGradientView.bounds)
    
    let ctx = UIGraphicsGetCurrentContext()
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradientCreateWithColors(colorSpace, [ColorSwatch.sr_mediumTeal.CGColor, ColorSwatch.sr_darkChalkGreen.CGColor], [0.0, 1.0])
    CGContextDrawRadialGradient(ctx, gradient, center, 20.0, endPoint, 50.0, .DrawsAfterEndLocation)
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(circularGradientView)
    self.view.addSubview(gView)
  }
}

class GradientView: UIView {
  override func drawRect(rect: CGRect) {
    let center: CGPoint = CGRectGetMidX(rect)*&CGRectGetMidY(rect)
    let endPoint: CGPoint = CGRectGetMaxX(rect)*&CGRectGetMaxY(rect)
    
    let ctx = UIGraphicsGetCurrentContext()
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradientCreateWithColors(colorSpace, [ColorSwatch.sr_mediumTeal.CGColor, ColorSwatch.sr_darkChalkGreen.CGColor], [0.0, 1.0])
    CGContextDrawRadialGradient(ctx, gradient, center, 20.0, endPoint, 50.0, .DrawsAfterEndLocation)
  }
}
