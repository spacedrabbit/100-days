//
//  HexShapes.swift
//  One00Days
//
//  Created by Louis Tur on 3/6/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

typealias HexPoints = [CGPoint]
typealias HexColors = (leftColor: UIColor, rightColor: UIColor, topColor: UIColor)
typealias PrismColors = (leftColor: UIColor, rightColor: UIColor, bottomColor: UIColor)

class HexCube {
  
  static let numberOfVertices: Int = 6
  var vertexPoints: HexPoints = []
  
  var leftsidePoints: HexPoints = []
  var rightsidePoints: HexPoints = []
  var topsidePoints: HexPoints = []
  var prismLeftSidePoints: HexPoints = []
  var prismRightSidePoints: HexPoints = []
  
  var centerPoint: CGPoint = CGPointMake(0.0, 0.0)
  var prismApexPoint: CGPoint = CGPointMake(0.0, 0.0)
  
  
  internal func vertexPointsForHexCube(withOrigin origin: CGPoint, radius: CGFloat) -> HexPoints{
    var points: HexPoints = []
    let center: CGPoint = origin
    let radius: CGFloat = radius
    let angleSize: CGFloat = deg2Rad((360.0 / CGFloat(HexCube.numberOfVertices)))
    let rotationAdjustment: CGFloat = deg2Rad(90.0) // rotates hex a bit for stylistic purpose
    
    for vertex in 1...HexCube.numberOfVertices {
      let dx: CGFloat = center.x - radius * cos(CGFloat(vertex) * angleSize + rotationAdjustment)
      let dy: CGFloat = center.y - radius * sin(CGFloat(vertex) * angleSize + rotationAdjustment)
      
      points.append(CGPointMake(dx, dy))
    }
    
    self.vertexPoints = points;
    self.leftsidePoints = [points[2], points[3], points[4]]
    self.rightsidePoints = [points[0], points[1], points[2]]
    self.topsidePoints = [points[4], points[5], points[0]]
    self.centerPoint = center
    
    self.prismApexPoint = self.midPointOf(points[4], b: points[0])
    self.prismLeftSidePoints = [self.prismApexPoint, points[2], points[3]]
    self.prismRightSidePoints = [self.prismApexPoint, points[1], points[2]]
    
    return points
  }
  
  
  /// Drawing functions
  internal func drawHexCube(inView view: UIView, colors: HexColors) {
    
    let leftsideLayer: CAShapeLayer = self.drawLeftsideOfHex(self.leftsidePoints, color: colors.leftColor)
    let rightsideLayer: CAShapeLayer = self.drawRightsideOfHex(self.rightsidePoints, color: colors.rightColor)
    let topsideLayer: CAShapeLayer = self.drawTopsideOfHex(self.topsidePoints, color: colors.topColor)
    
    view.layer.addSublayer(leftsideLayer)
    view.layer.addSublayer(rightsideLayer)
    view.layer.addSublayer(topsideLayer)
  }
  
  internal func drawPrismOnCube(inView view: UIView, colors: PrismColors) {
    let prismLeftLayer: CAShapeLayer = self.drawLeftsideOfPrism(self.prismLeftSidePoints, color: colors.leftColor)
    let prismRightLayer: CAShapeLayer = self.drawRightsideOfPrism(self.prismRightSidePoints, color: colors.rightColor)
    
    view.layer.addSublayer(prismLeftLayer)
    view.layer.addSublayer(prismRightLayer)
  }
  
  /// Helper Drawing Functions
  private func drawLeftsideOfHex(points: HexPoints, color: UIColor) -> CAShapeLayer {
    let path: UIBezierPath = UIBezierPath()
    path.moveToPoint(points[0])
    path.addLineToPoint(points[1])
    path.addLineToPoint(points[2])
    path.addLineToPoint(self.centerPoint)
    path.closePath()
    
    let layer: CAShapeLayer = CAShapeLayer()
    layer.path = path.CGPath
    layer.fillColor = color.CGColor
    layer.strokeColor = color.CGColor
    layer.lineWidth = 2.0
    
    path.stroke()
    return layer
  }
  
  private func drawRightsideOfHex(points: HexPoints, color: UIColor) -> CAShapeLayer {
    return self.drawLeftsideOfHex(points, color: color)
  }
  
  private func drawTopsideOfHex(points: HexPoints, color: UIColor) -> CAShapeLayer {
    return self.drawLeftsideOfHex(points, color: color)
  }
  
  private func drawLeftsideOfPrism(points: HexPoints, color: UIColor) -> CAShapeLayer {
    let path: UIBezierPath = UIBezierPath()
    path.moveToPoint(points[0])
    path.addLineToPoint(points[1])
    path.addLineToPoint(points[2])
    path.closePath()
    
    let layer: CAShapeLayer = CAShapeLayer()
    layer.path = path.CGPath
    layer.fillColor = color.CGColor
    layer.strokeColor = color.CGColor
    layer.lineWidth = 2.0
    
    path.stroke()
    return layer
  }
  
  private func drawRightsideOfPrism(points: HexPoints, color: UIColor) -> CAShapeLayer {
    return self.drawLeftsideOfPrism(points, color: color)
  }
  
  /// Helpers
  private func deg2Rad(degrees: CGFloat) -> CGFloat {
    return CGFloat(M_PI) * degrees/180.0
  }
  
  private func midPointOf(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPointMake((a.x + b.x / 2.0), (a.y + b.y / 2.0))
  }
}
