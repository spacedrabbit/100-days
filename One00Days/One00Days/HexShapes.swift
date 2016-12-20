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
  // TODO: need to map this enum to their CGPoints
  enum HexPlacement {
    case toTheLeft
    case toTheRight
    case above
    case below
    case infront
    case behind
  }
  
  static let numberOfVertices: Int = 6
  var vertexPoints: HexPoints = []
  
  var leftSidePoints: HexPoints = []
  var frontSidePoints: HexPoints = []
  var topSidePoints: HexPoints = []
  var bottomSidePoints: HexPoints = []
  var rightSidePoints: HexPoints = []
  var backSidePoints: HexPoints = []
  
  var prismLeftSidePoints: HexPoints = []
  var prismFrontSidePoints: HexPoints = []
  
  var centerPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var prismApexPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var originPointForHexPlacedAbove: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var originPointForHexPlacedBelow: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var originPointForHexToTheLeft: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var originPointForHexToTheRight: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var originPointForHexInFront: CGPoint = CGPoint(x: 0.0, y: 0.0)
  var originPointForHexPlacedBehind: CGPoint = CGPoint(x: 0.0, y: 0.0)
  
  let defaultHexColorPalette: HexColors = (ColorSwatch.sr_coolWhite, ColorSwatch.sr_darkChalkGreen, ColorSwatch.sr_mintGreen)
  let defaultPrismColorPalette: PrismColors = (ColorSwatch.sr_darkTeal, ColorSwatch.sr_mediumTeal, ColorSwatch.sr_coolWhite)
  
  
  // TODO: this is getting all a little too messy
  
  // 1.  This doesn't need to return the points, it's of no use to anyone other than this class. Make private
  // alternatively, keep this, and have drawHexCube(inView:colors:) call this directly
  internal func vertexPointsForHexCube(withOrigin origin: CGPoint, radius: CGFloat) -> HexPoints{
    var points: HexPoints = []
    let center: CGPoint = origin
    let radius: CGFloat = radius
    let angleSize: CGFloat = deg2Rad((360.0 / CGFloat(HexCube.numberOfVertices)))
    let rotationAdjustment: CGFloat = deg2Rad(90.0) // rotates hex a bit for stylistic purpose
    
    for vertex in 1...HexCube.numberOfVertices {
      let dx: CGFloat = center.x - radius * cos(CGFloat(vertex) * angleSize + rotationAdjustment)
      let dy: CGFloat = center.y - radius * sin(CGFloat(vertex) * angleSize + rotationAdjustment)
      
      points.append(CGPoint(x: dx, y: dy))
    }
    
    self.vertexPoints = points;
    self.leftSidePoints = [points[2], points[3], points[4]]
    self.frontSidePoints = [points[0], points[1], points[2]]
    self.topSidePoints = [points[4], points[5], points[0]]
    self.bottomSidePoints = [points[1], points[2], points[3]]
    self.rightSidePoints = [points[5], points[0], points[1]]
    self.backSidePoints = [points[3], points[4], points[5]]
    self.centerPoint = center
    
    self.originPointForHexPlacedAbove = points[5]
    self.originPointForHexPlacedBelow = points[2]
    self.originPointForHexToTheLeft = points[3]
    self.originPointForHexToTheRight = points[0]
    self.originPointForHexInFront = points[1]
    self.originPointForHexPlacedBehind = points[4]
    
    self.prismApexPoint = self.midPointOf(points[4], b: points[0])
    self.prismLeftSidePoints = [self.prismApexPoint, points[2], points[3]]
    self.prismFrontSidePoints = [self.prismApexPoint, points[1], points[2]]
    
    return points
  }
  
  
  /// Drawing functions
  // TODO: - this is probably better returning a view or layer than adding to it internally
  internal func drawHexCube(inView view: UIView, colors: HexColors) {
    
    let leftsideLayer: CAShapeLayer = self.drawLeftSideOfHex(self.leftSidePoints, color: colors.leftColor)
    let frontSideLayer: CAShapeLayer = self.drawFrontSideOfHex(self.frontSidePoints, color: colors.rightColor)
    let topsideLayer: CAShapeLayer = self.drawTopSideOfHex(self.topSidePoints, color: colors.topColor)
    
    view.layer.addSublayer(leftsideLayer)
    view.layer.addSublayer(frontSideLayer)
    view.layer.addSublayer(topsideLayer)
  }
  
  internal func drawDefaultHexCube(inView view: UIView) {
    self.drawHexCube(inView: view, colors: self.defaultHexColorPalette)
  }
  
  
  // TODO: - "on top of" and not "on" the cube
  internal func drawPrismOnCube(inView view: UIView, colors: PrismColors) {
    let prismLeftLayer: CAShapeLayer = self.drawLeftSideOfPrism(self.prismLeftSidePoints, color: colors.leftColor)
    let prismFrontLayer: CAShapeLayer = self.drawFrontSideOfPrism(self.prismFrontSidePoints, color: colors.rightColor)
    
    view.layer.addSublayer(prismLeftLayer)
    view.layer.addSublayer(prismFrontLayer)
  }
  
  internal func drawDefaultPrismOnCube(inView view: UIView) {
    self.drawPrismOnCube(inView: view, colors: self.defaultPrismColorPalette)
  }
  
  /// Helper Drawing Functions
  fileprivate func drawLeftSideOfHex(_ points: HexPoints, color: UIColor) -> CAShapeLayer {
    let path: UIBezierPath = UIBezierPath()
    path.move(to: points[0])
    path.addLine(to: points[1])
    path.addLine(to: points[2])
    path.addLine(to: self.centerPoint)
    path.close()
    
    let layer: CAShapeLayer = CAShapeLayer()
    layer.path = path.cgPath
    layer.fillColor = color.cgColor
    layer.strokeColor = color.cgColor
    layer.lineWidth = 2.0
    
    path.stroke()
    return layer
  }
  
  fileprivate func drawFrontSideOfHex(_ points: HexPoints, color: UIColor) -> CAShapeLayer {
    return self.drawLeftSideOfHex(points, color: color)
  }
  
  fileprivate func drawTopSideOfHex(_ points: HexPoints, color: UIColor) -> CAShapeLayer {
    return self.drawLeftSideOfHex(points, color: color)
  }
  
  fileprivate func drawLeftSideOfPrism(_ points: HexPoints, color: UIColor) -> CAShapeLayer {
    let path: UIBezierPath = UIBezierPath()
    path.move(to: points[0])
    path.addLine(to: points[1])
    path.addLine(to: points[2])
    path.close()
    
    let layer: CAShapeLayer = CAShapeLayer()
    layer.path = path.cgPath
    layer.fillColor = color.cgColor
    layer.strokeColor = color.cgColor
    layer.lineWidth = 1.0
    layer.lineJoin = kCALineCapRound
    
    path.stroke()
    return layer
  }
  
  fileprivate func drawFrontSideOfPrism(_ points: HexPoints, color: UIColor) -> CAShapeLayer {
    return self.drawLeftSideOfPrism(points, color: color)
  }
  
  /// Helpers
  fileprivate func deg2Rad(_ degrees: CGFloat) -> CGFloat {
    return CGFloat(M_PI) * degrees/180.0
  }
  
  fileprivate func midPointOf(_ a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0)
  }
}
