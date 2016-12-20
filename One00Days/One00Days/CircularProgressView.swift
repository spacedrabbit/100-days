//
//  CircularProgressView.swift
//  One00Days
//
//  Created by Louis Tur on 3/14/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

open class CircularProgressView: UIView {
  
    open var lineWidth: CGFloat = 4.0 {
      didSet {
        self.configureShapeLayer()
      }
    }
  
    open var progressColor: UIColor = UIColor.red {
      didSet {
        self.configureShapeLayer()
      }
    }
  
    open var trackColor: UIColor = UIColor.orange {
      didSet {
        self.configureShapeLayer()
      }
    }
  
    open var progress: CGFloat = 25.0 {
      didSet {
        self.configureShapeLayer()
      }
    }
  
  internal var circleShape: CAShapeLayer = {
    return CAShapeLayer()
  }()
  
  fileprivate lazy var shapeLayer: CAShapeLayer = {
    return CAShapeLayer()
  }()
  
  //MARK: Animation
  
//    public override func drawRect(rect: CGRect) {
  //    let context: CGContext? = UIGraphicsGetCurrentContext()
  //    CGContextBeginPath(context)
  //    CGContextMoveToPoint(context, CGRectGetMidX(bounds), bounds.origin.y)
  //
  //    let startAngle: CGFloat = -CGFloat(M_PI_2) // -(CGFloat(M_PI)) * 2.0 / 4.0
  //    let endAngle: CGFloat = CGFloat(M_PI) //startAngle //CGFloat(M_PI) * 2.0 * (1.0 - 0.25)
  //    let radius: CGFloat = (fmin(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2.0) - (self.lineWidth / 2.0);
  //    CGContextAddArc(context, CGRectGetMidX(bounds), CGRectGetMidY(bounds), radius, startAngle, endAngle, 0)
  //
  //    CGContextSetLineWidth(context, self.lineWidth)
  //    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor)
  //    CGContextStrokePath(context)
//    }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.configureShapeLayer()
    self.layer.addSublayer(self.circleShape)
    
    let progressTopCirclePath: UIBezierPath = UIBezierPath(ovalIn: frame.insetBy(dx: 2.0, dy: 2.0))
    let topCircleLayer: CAShapeLayer = CAShapeLayer()
    topCircleLayer.path = progressTopCirclePath.cgPath
    topCircleLayer.fillColor = UIColor.purple.cgColor
    topCircleLayer.strokeColor = UIColor.green.cgColor
    topCircleLayer.lineWidth = 0.0
    
    self.layer.addSublayer(topCircleLayer)
  }
  
  func attachRotationAnimation() {
    let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    anim.duration = 4.0
    anim.fromValue = 0.0
    anim.toValue = 1.0
    anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    anim.isRemovedOnCompletion = false
    
    self.circleShape.add(anim, forKey: "progress")
  }
  
  internal func configureShapeLayer() {
    if let layer: CAShapeLayer = self.circleShape {
      layer.path = pathForProgressAmount(self.progress).cgPath
      layer.frame = self.bounds
      layer.fillColor = self.progressColor.cgColor
      layer.lineWidth = self.lineWidth
      layer.strokeColor = self.progressColor.cgColor
      layer.backgroundColor = UIColor.blue.cgColor //UIColor.clearColor().CGColor
    }
  }
  
  internal func pathForProgressAmount(_ progress: CGFloat) -> UIBezierPath {
    let progressInRad: CGFloat = CGFloat(M_PI) * ((3.6 * progress) / 180.0)
    
    let center: CGPoint = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    let startAngle: CGFloat = -CGFloat(M_PI_2)
    let endAngle: CGFloat =  startAngle + progressInRad
    let radius: CGFloat = fmin(self.bounds.width, self.bounds.height) / 2.0 - (self.lineWidth / 2.0);
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open func startAnimating(restart: Bool) {
    if restart {
      self.progress = 0.0
    }
    self.attachRotationAnimation()
    self.setNeedsDisplay()
  }
}
