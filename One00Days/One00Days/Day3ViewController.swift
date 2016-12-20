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
    view.backgroundColor = UIColor.red
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
    
    self.centeredView.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(100.0)
      make.width.equalTo(100.0)
      make.center.equalTo(self.view.snp.center)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.centeredView)
  }
  
  internal func drawCircle() {
    self.drawCircleIn(self.centeredView)
  }
  
  internal func drawCircleIn(_ view: UIView) {
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let circlePath: UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = UIColor.blue.cgColor
    view.layer.addSublayer(shapeLayer)

    // not actually animated right now
    let circleAnimation: CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
    circleAnimation.duration = 2.0
    circleAnimation.repeatCount = 1
    circleAnimation.fromValue = NSNumber(value: 0.0 as Float)
    circleAnimation.toValue = NSNumber(value: 1.0 as Float)
    
    shapeLayer.add(circleAnimation, forKey: "drawCircleAnimation")
  }
  
  internal func spinTheShitOuttaThatSquare() {
    self.centeredView.transform = CGAffineTransform.identity
    UIView.animate(withDuration: 1.0, animations: { () -> Void in
      self.centeredView.transform = CGAffineTransform(rotationAngle: CGFloat(180.0 * M_PI) / 180.0)
      }, completion: { (completion: Bool) -> Void in
        self.spinTheShitOuttaThatSquare()
    }) 
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
