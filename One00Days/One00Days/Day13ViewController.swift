//
//  Day13ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/4/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import CoreGraphics

class Day13ViewController: UIViewController {
  
  lazy var hexView: UIView = {
    let view: UIView = UIView(frame: CGRectMake(150.0,150.0, 100.0, 100.0))
    view.backgroundColor = UIColor.grayColor()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    let circle: CALayer = drawCircle(10.0, center: CGPointMake(200.0, 200.0))
    self.view.layer.addSublayer(circle)
    
    self.view.addSubview(hexView)
    
    let vertices: [CGPoint] = getPointsForHexagonPath(hexView)
    
    drawHexFromPoints(vertices, view: hexView)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func degrees2Rad(degrees: CGFloat) -> CGFloat {
    return CGFloat(M_PI) * degrees/180.0
  }
  
  internal func drawCircle(radius: CGFloat, center: CGPoint) -> CALayer {
    
    let circleArcPaths: UIBezierPath = UIBezierPath()
    for segment in 0...6 {
      let arc: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle:degrees2Rad(1.0 * CGFloat(segment)), endAngle: degrees2Rad(60.0 * CGFloat(segment)), clockwise: true)
      circleArcPaths.appendPath(arc)
    }
    
    let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    circleShapeLayer.path = circleArcPaths.CGPath
    circleShapeLayer.lineWidth = 2.0
    circleShapeLayer.strokeColor = UIColor.blackColor().CGColor
    circleShapeLayer.fillColor = UIColor.clearColor().CGColor
    
    circleArcPaths.stroke()
    
    return circleShapeLayer
    
  }
  
  internal func drawHexFromPoints(vertices: [CGPoint], view: UIView) {
    
    let hexPath: UIBezierPath = UIBezierPath()
    hexPath.moveToPoint(vertices[0])
    hexPath.addLineToPoint(vertices[1])
    hexPath.addLineToPoint(vertices[2])
    hexPath.addLineToPoint(vertices[3])
    hexPath.addLineToPoint(vertices[4])
    hexPath.addLineToPoint(vertices[5])
    hexPath.closePath()
    
    
    let hexShapeLayer: CAShapeLayer = CAShapeLayer()
    hexShapeLayer.strokeColor = UIColor.redColor().CGColor
    hexShapeLayer.fillColor = UIColor.clearColor().CGColor
    hexShapeLayer.lineWidth = 3.0
    hexShapeLayer.path = hexPath.CGPath
    
    hexPath.stroke()
    
    view.layer.addSublayer(hexShapeLayer)
  }
  
  internal func getPointsForHexagonPath(inView: UIView) -> [CGPoint] {
    let viewCenter: CGPoint = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
    let viewRadius: CGFloat = viewCenter.x
    let numberOfPoints: Int = 6
    let angleSize: CGFloat =  degrees2Rad(360.0 / CGFloat(numberOfPoints))
    
    var vertexPoints: [CGPoint] = []
    for point in 1...numberOfPoints {
      let dx: CGFloat = viewRadius * cos(CGFloat(point) * angleSize)
      let dy: CGFloat = viewRadius * sin(CGFloat(point) * angleSize)
      
      vertexPoints.append(CGPointMake(dx, dy))
    }
    
    return vertexPoints
  }
  
  
}
