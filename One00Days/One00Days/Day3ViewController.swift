//
//  Day3ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/23/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day3ViewController: UIViewController {
  
  lazy var centeredView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.drawCircleIn(self.centeredView)
    self.spinTheShitOuttaThatSquare()
//    let timer: NSTimer = NSTimer(fireDate: NSDate.init(timeIntervalSinceNow: 10.0), interval: 10.0, target: self, selector: "drawCircle", userInfo: nil, repeats: false)
//    NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
//    timer.fire()
  }
  
  internal func configureConstraints() {
    
    self.centeredView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(100.0)
      make.width.equalTo(100.0)
      make.center.equalTo(self.view.snp_center)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.centeredView)
  }
  
  internal func drawCircle() {
    self.drawCircleIn(self.centeredView)
  }
  
  internal func drawCircleIn(view: UIView) {
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let circlePath: UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, 100.0, 100.0))
    shapeLayer.path = circlePath.CGPath
    shapeLayer.fillColor = UIColor.blueColor().CGColor
    view.layer.addSublayer(shapeLayer)

    // not actually animated right now
    let circleAnimation: CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
    circleAnimation.duration = 2.0
    circleAnimation.repeatCount = 1
    circleAnimation.fromValue = NSNumber(float: 0.0)
    circleAnimation.toValue = NSNumber(float: 1.0)
    
    shapeLayer.addAnimation(circleAnimation, forKey: "drawCircleAnimation")
  }
  
  internal func spinTheShitOuttaThatSquare() {
    self.centeredView.transform = CGAffineTransformIdentity
    UIView.animateWithDuration(1.0, animations: { () -> Void in
      self.centeredView.transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI) / 180.0)
      }) { (completion: Bool) -> Void in
        self.spinTheShitOuttaThatSquare()
    }
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
