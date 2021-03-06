//
//  Day24ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/15/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

infix operator +&{
  associativity left
  precedence 150
}

infix operator *&{
  associativity left
  precedence 150
}

public func +&(lhs: CGFloat, rhs: CGFloat) -> CGSize {
  return CGSize(width: lhs, height: rhs)
}

public func *&(lhs: CGFloat, rhs: CGFloat) -> CGPoint {
  return CGPoint(x: lhs, y: rhs)
}

class Day24ViewController: UIViewController {
  
  lazy var gradientView: UIView = {
  let view: UIView = UIView()
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 3.0
  return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorSwatch.sr_coolWhite
    setupViewHierarchy()
    configureConstraints()
    drawGradientIn(self.gradientView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func drawGradientIn(_ view: UIView) {
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [ColorSwatch.sr_hipsterAvocado.cgColor, ColorSwatch.sr_coolWhite.cgColor]
    gradientLayer.locations = [0.0, 0.8]
    gradientLayer.startPoint = 0.0*&0.0
    gradientLayer.endPoint = 1.0*&1.0
    
    view.layer.addSublayer(gradientLayer)
  }
  
  internal func configureConstraints() {
    self.gradientView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(150.0+&150.0)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(gradientView)
  }
  
}
