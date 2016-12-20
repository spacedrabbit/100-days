//
//  Day26ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/17/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day26ViewController: UIViewController, CAAnimationDelegate {
  
  lazy var button: UIButton = {
    let b: UIButton = UIButton(type: UIButtonType.roundedRect)
    b.setTitle("Push me", for: UIControlState())
    b.addTarget(self, action: #selector(Day26ViewController.didTouchButt(_:)), for: .touchUpInside)
    b.backgroundColor = ColorSwatch.sr_hipsterBlueBlack
    b.setTitleColor(ColorSwatch.sr_coolWhite, for: UIControlState())
    return b
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorSwatch.sr_coolWhite
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  internal func configureConstraints() {
    self.button.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.view)
      make.size.equalTo(200.0+&50.0)
    }
  }
  
  internal func didTouchButt(_ sender: AnyObject?) {
    let buttLayer = drawExpandingLayer()
    buttLayer.position = CGPoint(x: self.view.layer.bounds.midX - (0.5 * buttLayer.bounds.width) , y: self.view.layer.bounds.midY - (0.5 * buttLayer.bounds.height))
    self.view.layer.addSublayer(buttLayer)
    
  }
  
  internal func setupViewHierarchy() {
   self.view.addSubview(button)
  }
  
  internal func drawExpandingLayer() -> CALayer {
    let path: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = ColorSwatch.sr_darkChalkGreen.cgColor
    shapeLayer.strokeColor = ColorSwatch.sr_darkChalkGreen.cgColor
    
    attachAnimationToLayer(shapeLayer)
    
    return shapeLayer
  }
  
  internal func attachAnimationToLayer(_ layer: CALayer) {
    let expandingAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
    expandingAnimation.duration = 1.50
    expandingAnimation.toValue = 25.0
    expandingAnimation.isRemovedOnCompletion = true
    expandingAnimation.isAdditive = true
    
    expandingAnimation.delegate = self
    
    layer.add(expandingAnimation, forKey: "scale")
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if flag {
      self.view.layer.removeAnimation(forKey: "scale")
    }
  }
}
