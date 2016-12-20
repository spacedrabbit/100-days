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
    self.backgroundColor = UIColor.clear
    self.isUserInteractionEnabled = true
    self.addTarget(self, action: #selector(TappableCircleButton.buttonTouched(_:)), for: [.touchDown, .touchDragInside])
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func draw(_ rect: CGRect) {
    let circlePath: UIBezierPath = UIBezierPath(roundedRect: rect.insetBy(dx: 4.0, dy: 4.0), cornerRadius: rect.height/2.0)
    let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    circleShapeLayer.path = circlePath.cgPath
    circleShapeLayer.strokeColor = UIColor.blue.cgColor
    circleShapeLayer.fillColor = UIColor.yellow.cgColor
    circleShapeLayer.lineCap = kCALineCapSquare
    circleShapeLayer.lineWidth = 4.0
    
    let horizontalLinePath: UIBezierPath = UIBezierPath()
    horizontalLinePath.move(to: CGPoint(x: 12.0, y: rect.midY))
    horizontalLinePath.addLine(to: CGPoint(x: rect.maxX - 12.0, y: rect.midY))
    horizontalLinePath.close()
    let horizontalLineShapeLayer: CAShapeLayer = CAShapeLayer()
    horizontalLineShapeLayer.path = horizontalLinePath.cgPath
    horizontalLineShapeLayer.strokeColor = UIColor.red.cgColor
    horizontalLineShapeLayer.lineCap = kCALineCapSquare
    horizontalLineShapeLayer.lineWidth = 4.0
    
    let verticalLinePath: UIBezierPath = UIBezierPath()
    verticalLinePath.move(to: CGPoint(x: rect.width / 2.0, y: 12.0))
    verticalLinePath.addLine(to: CGPoint(x: rect.width / 2.0, y: rect.height - 12.0))
    let verticalLineShapeLayer: CAShapeLayer = CAShapeLayer()
    verticalLineShapeLayer.path = verticalLinePath.cgPath
    verticalLineShapeLayer.strokeColor = UIColor.red.cgColor
    verticalLineShapeLayer.lineCap = kCALineCapSquare
    verticalLineShapeLayer.lineWidth = 4.0
    
    
    layer.addSublayer(circleShapeLayer)
    circleShapeLayer.addSublayer(horizontalLineShapeLayer)
    circleShapeLayer.addSublayer(verticalLineShapeLayer)
    
    circlePath.stroke()
    horizontalLinePath.stroke()
    verticalLinePath.stroke()
  }
  
  internal func buttonTouched(_ sender: AnyObject?) {
    print("TOUCHED")
    animateForHightlightedState()
  }
  
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    print("begin tracking?")
    return true
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    print("continued tracking")
    return true
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
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
    pressedAnimation.isRemovedOnCompletion = false
    
    UIView.animate(withDuration: 0.30, animations: { () -> Void in
      self.layer.add(pressedAnimation, forKey: kPressedDownKey)
      }, completion: { (complete: Bool) -> Void in
        self.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0.85, y: 0.85))
    }) 
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
    
    UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in
      
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: { () -> Void in
        self.layer.transform = CATransform3DIdentity
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: { () -> Void in
        self.layer.add(releasedAnimation, forKey: kReleasedKey)
      })
      
      }) { (complete: Bool) -> Void in
        self.layer.removeAnimation(forKey: kReleasedKey)
    }
  }
  
}
