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

func degreesToRadians(degrees: CGFloat) -> CGFloat {
  return CGFloat(M_PI) * degrees/180
}

func drawSecondsMarker(context: CGContextRef, x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor) {
  let path = CGPathCreateMutable()
  CGPathMoveToPoint(path, nil, radius, 0)
  CGPathAddLineToPoint(path, nil, x, y)
  CGPathCloseSubpath(path)
  CGContextAddPath(context, path)
  CGContextSetLineWidth(context, 1.0)
  CGContextSetStrokeColorWithColor(context, color.CGColor)
  CGContextStrokePath(context)
}

class ClockView: UIView {
  
    override func drawRect(rect: CGRect) {
      let ctx = UIGraphicsGetCurrentContext()
      let radius = CGRectGetWidth(rect) / 2.5
      let endAngle: CGFloat = CGFloat(2.0 * M_PI)
      
      CGContextAddArc(ctx!, CGRectGetMidX(rect), CGRectGetMidY(rect), radius, 0, endAngle, 1)
      CGContextSetFillColorWithColor(ctx!, UIColor.blueColor().CGColor)
      CGContextSetStrokeColorWithColor(ctx!, UIColor.whiteColor().CGColor)
      CGContextSetLineWidth(ctx!, 3.0)
      CGContextDrawPath(ctx!, .FillStroke)
      
      for i in 1...60 {
        CGContextSaveGState(ctx)
        CGContextTranslateCTM(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect))
        CGContextRotateCTM(ctx, degreesToRadians(CGFloat(i) * 6.0)) // ((60 ticks / 360 degree) * tick #)
        
        if i%5 == 0 {
          drawSecondsMarker(ctx!, x: radius - 10.0, y: 0, radius: radius, color: UIColor.whiteColor())
          
          let aFont = UIFont(name: "Optima-Bold", size: radius/5)
          let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.whiteColor()]
          let text = CFAttributedStringCreate(nil, "\(i)", attr)
          let line = CTLineCreateWithAttributedString(text)
          let bounds = CTLineGetBoundsWithOptions(line, .ExcludeTypographicShifts)
          CGContextSetLineWidth(ctx, 1.0)
          CGContextSetTextDrawingMode(ctx, .Stroke)
          CGContextSetTextPosition(ctx, radius - bounds.size.width * 8, -CGRectGetMidY(rect))
          CTLineDraw(line, ctx!)
        } else {
          drawSecondsMarker(ctx!, x: radius - 5.0, y: 0, radius: radius, color: UIColor.whiteColor())
        }
        CGContextRestoreGState(ctx)
      }
      
//      CGContextSaveGState(ctx)
//      CGContextTranslateCTM(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect))
      let newCTX = UIGraphicsGetCurrentContext()
      CGContextRotateCTM(newCTX, degreesToRadians(60.0))
//      CGContextRestoreGState(ctx)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }


}
