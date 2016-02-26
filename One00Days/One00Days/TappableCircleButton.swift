//
//  TappableCircleButton.swift
//  One00Days
//
//  Created by Louis Tur on 2/25/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let kTransformScaleKey: String = "transform.scale"
let kPressedDownKey: String = "pressedDown"
let kReleasedKey: String = "released"

class TappableCircleButton: UIControl {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    self.userInteractionEnabled = true
    self.addTarget(self, action: "buttonTouched:", forControlEvents: [.TouchDown, .TouchDragInside])
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func drawRect(rect: CGRect) {
    let circlePath: UIBezierPath = UIBezierPath(roundedRect: CGRectInset(rect, 4.0, 4.0), cornerRadius: rect.height/2.0)
    let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    circleShapeLayer.path = circlePath.CGPath
    circleShapeLayer.strokeColor = UIColor.blueColor().CGColor
    circleShapeLayer.fillColor = UIColor.yellowColor().CGColor
    circleShapeLayer.lineCap = kCALineCapSquare
    circleShapeLayer.lineWidth = 4.0
    
    let horizontalLinePath: UIBezierPath = UIBezierPath()
    horizontalLinePath.moveToPoint(CGPointMake(12.0, CGRectGetMidY(rect)))
    horizontalLinePath.addLineToPoint(CGPointMake(CGRectGetMaxX(rect) - 12.0, CGRectGetMidY(rect)))
    horizontalLinePath.closePath()
    let horizontalLineShapeLayer: CAShapeLayer = CAShapeLayer()
    horizontalLineShapeLayer.path = horizontalLinePath.CGPath
    horizontalLineShapeLayer.strokeColor = UIColor.redColor().CGColor
    horizontalLineShapeLayer.lineCap = kCALineCapSquare
    horizontalLineShapeLayer.lineWidth = 4.0
    
    let verticalLinePath: UIBezierPath = UIBezierPath()
    verticalLinePath.moveToPoint(CGPointMake(rect.width / 2.0, 12.0))
    verticalLinePath.addLineToPoint(CGPointMake(rect.width / 2.0, rect.height - 12.0))
    let verticalLineShapeLayer: CAShapeLayer = CAShapeLayer()
    verticalLineShapeLayer.path = verticalLinePath.CGPath
    verticalLineShapeLayer.strokeColor = UIColor.redColor().CGColor
    verticalLineShapeLayer.lineCap = kCALineCapSquare
    verticalLineShapeLayer.lineWidth = 4.0
    
    
    layer.addSublayer(circleShapeLayer)
    circleShapeLayer.addSublayer(horizontalLineShapeLayer)
    circleShapeLayer.addSublayer(verticalLineShapeLayer)
    
    circlePath.stroke()
    horizontalLinePath.stroke()
    verticalLinePath.stroke()
  }
  
  internal func buttonTouched(sender: AnyObject?) {
    print("TOUCHED")
    animateForHightlightedState()
  }
  
  override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    print("begin tracking?")
    return true
  }
  
  override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    print("continued tracking")
    return true
  }
  
  override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
    print("end tracking")
    if let buttonTouch: UITouch = touch {
      if let touchedView: UIView = buttonTouch.view {
        if touchedView == self {
          self.animateForReleaseState()
          
//          UIView.animateWithDuration(0.40, animations: { () -> Void in
//            self.layer.transform = CATransform3DIdentity
//            self.layer.removeAnimationForKey(kPressedDownKey)
//            }, completion: nil)
          
        }
      }
    }
  }
  
  internal func animateForHightlightedState() {
    let pressedAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: kTransformScaleKey)
    pressedAnimation.keyTimes = [0.0, 1.0]
    pressedAnimation.values = [1.0, 0.85]
    pressedAnimation.timingFunctions = [CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)]
    pressedAnimation.removedOnCompletion = false
    
    UIView.animateWithDuration(0.30, animations: { () -> Void in
      self.layer.addAnimation(pressedAnimation, forKey: kPressedDownKey)
      }) { (complete: Bool) -> Void in
        self.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.85, 0.85))
    }
  }
  
  internal func animateForReleaseState() {
    let releasedAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: kTransformScaleKey)
    releasedAnimation.keyTimes = [0.0, 0.15, 0.4, 0.6, 0.8, 1.0]
    releasedAnimation.values = [1.0, 1.5, 1.07, 1.02, 1.04, 1.0]
    releasedAnimation.timingFunctions = [
      CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear),
      CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut),
      CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut),
      CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut),
      CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear),
    ]
    
    UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
      
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: { () -> Void in
        self.layer.transform = CATransform3DIdentity
      })
      
      UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.75, animations: { () -> Void in
        self.layer.addAnimation(releasedAnimation, forKey: kReleasedKey)
      })
      
      }) { (complete: Bool) -> Void in
        self.layer.removeAnimationForKey(kReleasedKey)
    }
  }
  
}
