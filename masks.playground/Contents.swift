//: Playground - noun: a place where people can play

import UIKit
import CoreGraphics

var str = "Hello, playground"

func drawARect() -> UIView {
  let view: UIView = UIView(frame: CGRectMake(0.0, 0.0, 100.0, 200.0))
  view.backgroundColor = UIColor.yellowColor()
  let interiorView: UIView = UIView(frame: CGRectInset(view.frame, 10.0, 10.0))
  interiorView.backgroundColor = UIColor.redColor()
  view.addSubview(interiorView)
  
  let bezier: UIBezierPath = getSomeCurves()
  let mask: CAShapeLayer = makeTheMask(forPath: bezier)
  
//  interiorView.layer.addSublayer(mask)
  
  
  
  return view
  }

func getSomeCurves() -> UIBezierPath {
  let transparentFrame: CGRect = CGRectMake(5.0, 5.0, 20.0, 50.0)
  
  let maskLayerPathBase: UIBezierPath = UIBezierPath(roundedRect: transparentFrame, cornerRadius: 5.0)
  let maskLayerPathDefined: UIBezierPath = UIBezierPath(roundedRect: CGRectInset(transparentFrame, 4.0, 4.0), cornerRadius: 4.0)
  maskLayerPathBase.appendPath(maskLayerPathDefined)
  
  return maskLayerPathBase
}

func makeTheMask(forPath path: UIBezierPath) -> CAShapeLayer {
  let transparentFrameLocation = path.bounds
  let maskLayer: CAShapeLayer = CAShapeLayer()
  maskLayer.bounds = transparentFrameLocation
  maskLayer.frame = transparentFrameLocation
  maskLayer.path = path.CGPath
  maskLayer.backgroundColor = UIColor.whiteColor().CGColor
  maskLayer.fillRule = kCAFillRuleEvenOdd

  return maskLayer
}

let rects: UIView = drawARect()



