//
//  Day6.swift
//  One00Days
//
//  Created by Louis Tur on 2/28/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//
// See http://sketchytech.blogspot.co.uk/2014/11/swift-how-to-draw-clock-face-using.html?q=drawrect&view=flipcard

import UIKit
import CoreGraphics

func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
  return (180 / CGFloat(M_PI)) * degrees
}

func drawSecondsMarker(_ context: CGContext, x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor) {
  let path = CGMutablePath()
//  CGPathMoveToPoint(path, nil, radius, 0)
//  CGPathAddLineToPoint(path, nil, x, y)
  path.closeSubpath()
  context.addPath(path)
  context.setLineWidth(1.0)
  context.setStrokeColor(color.cgColor)
  context.strokePath()
}

class ClockView: UIView {
  
    override func draw(_ rect: CGRect) {
      let ctx = UIGraphicsGetCurrentContext()
      let radius = rect.width / 2.5
      let endAngle: CGFloat = CGFloat(2.0 * M_PI)
      
//      CGContextAddArc(ctx!, rect.midX, rect.midY, radius, 0, endAngle, 1)
      ctx!.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
      ctx!.setFillColor(UIColor.blue.cgColor)
      ctx!.setStrokeColor(UIColor.white.cgColor)
      ctx!.setLineWidth(3.0)
      ctx!.drawPath(using: .fillStroke)
      
      for i in 1...60 {
        ctx?.saveGState()
        ctx?.translateBy(x: rect.midX, y: rect.midY)
        ctx?.rotate(by: degreesToRadians(CGFloat(i) * 6.0)) // ((60 ticks / 360 degree) * tick #)
        
        if i%5 == 0 {
          drawSecondsMarker(ctx!, x: radius - 10.0, y: 0, radius: radius, color: UIColor.white)
          
//          let aFont = UIFont(name: "Optima-Bold", size: radius/5)
//          let attr: CFDictionary = Dictionary.init(dictionaryLiteral: (NSFontAttributeName : aFont!), (NSForegroundColorAttributeName : UIColor.white))
//          let text = CFAttributedStringCreate(nil, "\(i)" as CFString!, attr)
//          let line = CTLineCreateWithAttributedString(text!)
//          let bounds = CTLineGetBoundsWithOptions(line, .excludeTypographicShifts)
//          ctx?.setLineWidth(1.0)
//          ctx?.setTextDrawingMode(.stroke)
//          ctx?.textPosition = CGPoint(x: radius - bounds.size.width * 8, y: -rect.midY)
////          CGContextSetTextPosition(ctx, radius - bounds.size.width * 8, y: -rect.midY)
//          CTLineDraw(line, ctx!)
        } else {
          drawSecondsMarker(ctx!, x: radius - 5.0, y: 0, radius: radius, color: UIColor.white)
        }
        ctx?.restoreGState()
      }
      
//      CGContextSaveGState(ctx)
//      CGContextTranslateCTM(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect))
      let newCTX = UIGraphicsGetCurrentContext()
      newCTX?.rotate(by: degreesToRadians(60.0))
//      CGContextRestoreGState(ctx)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }


}
