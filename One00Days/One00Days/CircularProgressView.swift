//
//  CircularProgressView.swift
//  One00Days
//
//  Created by Louis Tur on 3/14/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

public class CircularProgressView: UIView {
  
    public var lineWidth: CGFloat = 4.0 {
      didSet {
        self.configureShapeLayer()
      }
    }
  
    public var progressColor: UIColor = UIColor.redColor() {
      didSet {
        self.configureShapeLayer()
      }
    }
  
    public var trackColor: UIColor = UIColor.orangeColor() {
      didSet {
        self.configureShapeLayer()
      }
    }
  
    public var progress: CGFloat = 25.0 {
      didSet {
        self.configureShapeLayer()
      }
    }
  
  internal var circleShape: CAShapeLayer = {
    return CAShapeLayer()
  }()
  
  private lazy var shapeLayer: CAShapeLayer = {
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
    
    let progressTopCirclePath: UIBezierPath = UIBezierPath(ovalInRect: CGRectInset(frame, 2.0, 2.0))
    let topCircleLayer: CAShapeLayer = CAShapeLayer()
    topCircleLayer.path = progressTopCirclePath.CGPath
    topCircleLayer.fillColor = UIColor.purpleColor().CGColor
    topCircleLayer.strokeColor = UIColor.greenColor().CGColor
    topCircleLayer.lineWidth = 0.0
    
    self.layer.addSublayer(topCircleLayer)
  }
  
  func attachRotationAnimation() {
    let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    anim.duration = 4.0
    anim.fromValue = 0.0
    anim.toValue = 1.0
    anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    anim.removedOnCompletion = false
    
    self.circleShape.addAnimation(anim, forKey: "progress")
  }
  
  internal func configureShapeLayer() {
    if let layer: CAShapeLayer = self.circleShape {
      layer.path = pathForProgressAmount(self.progress).CGPath
      layer.frame = self.bounds
      layer.fillColor = self.progressColor.CGColor
      layer.lineWidth = self.lineWidth
      layer.strokeColor = self.progressColor.CGColor
      layer.backgroundColor = UIColor.blueColor().CGColor //UIColor.clearColor().CGColor
    }
  }
  
  internal func pathForProgressAmount(progress: CGFloat) -> UIBezierPath {
    let progressInRad: CGFloat = CGFloat(M_PI) * ((3.6 * progress) / 180.0)
    
    let center: CGPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
    let startAngle: CGFloat = -CGFloat(M_PI_2)
    let endAngle: CGFloat =  startAngle + progressInRad
    let radius: CGFloat = fmin(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2.0 - (self.lineWidth / 2.0);
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func startAnimating(restart restart: Bool) {
    if restart {
      self.progress = 0.0
    }
    self.attachRotationAnimation()
    self.setNeedsDisplay()
  }
}