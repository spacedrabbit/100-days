//
//  Day26ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/17/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day26ViewController: UIViewController {
  
  lazy var button: UIButton = {
    let b: UIButton = UIButton(type: UIButtonType.RoundedRect)
    b.setTitle("Push me", forState: .Normal)
    b.addTarget(self, action: "didTouchButt:", forControlEvents: .TouchUpInside)
    b.backgroundColor = ColorSwatch.sr_hipsterBlueBlack
    b.setTitleColor(ColorSwatch.sr_coolWhite, forState: .Normal)
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
    self.button.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.view)
      make.size.equalTo(200.0+&50.0)
    }
  }
  
  internal func didTouchButt(sender: AnyObject?) {
    let buttLayer = drawExpandingLayer()
    buttLayer.position = CGPointMake(CGRectGetMidX(self.view.layer.bounds) - (0.5 * buttLayer.bounds.width) , CGRectGetMidY(self.view.layer.bounds) - (0.5 * buttLayer.bounds.height))
    self.view.layer.addSublayer(buttLayer)
    
  }
  
  internal func setupViewHierarchy() {
   self.view.addSubview(button)
  }
  
  internal func drawExpandingLayer() -> CALayer {
    let path: UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, 20.0, 20.0))
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = path.CGPath
    shapeLayer.fillColor = ColorSwatch.sr_darkChalkGreen.CGColor
    shapeLayer.strokeColor = ColorSwatch.sr_darkChalkGreen.CGColor
    
    attachAnimationToLayer(shapeLayer)
    
    return shapeLayer
  }
  
  internal func attachAnimationToLayer(layer: CALayer) {
    let expandingAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
    expandingAnimation.duration = 1.50
    expandingAnimation.toValue = 25.0
    expandingAnimation.removedOnCompletion = true
    expandingAnimation.additive = true
    
    expandingAnimation.delegate = self
    
    layer.addAnimation(expandingAnimation, forKey: "scale")
  }
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    if flag {
      self.view.layer.removeAnimationForKey("scale")
    }
  }
}
