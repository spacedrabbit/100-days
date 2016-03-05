//
//  Day13ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/4/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

/* references:
https://gist.github.com/sketchytech/74727d13a2a6176914a1
https://gist.github.com/sketchytech/746440080fb0121b0ab5
http://www.mathopenref.com/coordparamcircle.html
http://sketchytech.blogspot.co.uk/2014/11/the-power-of-hexagons-starting-from.html?q=drawrect&view=flipcard
*/


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
      circleArcPaths.appendPath(arc) // appendPath() doesn't force a closePath(), so there aren't any unwanted lines when creating the arcs
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
    let viewCenter: CGPoint = CGPointMake(CGRectGetMidX(inView.bounds), CGRectGetMidY(inView.bounds)) // effectively the origin of the circle to use
    let viewRadius: CGFloat = viewCenter.x // the radius of the circle that fits in this square
    let numberOfPoints: Int = 6 // 6 vertices in a hexagon
    let angleSize: CGFloat =  degrees2Rad((360.0 / CGFloat(numberOfPoints))) // size of angle for each arc in the circle, in radians. where each arc meets is effectively a point in the hexagon
    
    
    /*
    As the links above explain, the parametric formula of a circle is: 
    
    x = r * cos(𝛳)
    y = r * sin(𝛳)
    
    where:
    r = radius of the circle
    𝛳 = the angle in radians (corresponds to the interior angle of the line segment of (origin.x, origin.y) and (x, y) with respect to the x axis)
    
    If the center of the circle is not the origin point, you just have to +/- the distance from the origin to the center of the circle, resulting in something like:
    
    x = w - (r * cos(𝛳))
    y = h - (r * sin(𝛳))

    In this example, it's easy to calculate this distance since the view we're drawing in defines the bounds of the circle. So the radius ends up being (width/2.0)
    Coordinate in views are measured relative to the top left corner of a view, meaning that in order to get the correct translation of the hexagon's center, we need
    to subtract the radius from each point to shift drawing to be done relative to the center of the view
    
    */
    var vertexPoints: [CGPoint] = []
    for point in 1...numberOfPoints {
      let dx: CGFloat = viewRadius - viewRadius * cos(CGFloat(point) * angleSize )
      let dy: CGFloat = viewRadius - viewRadius * sin(CGFloat(point) * angleSize )
      
      /*
      This loop will create a hexagon with it's first vertex point resting on the x-axis. if you wanted to rotate it so that this first point begins elsewhere,
      it is possible to just add an additional amount of radians to do so. 
      
      // this code will rotate the hex drawing 90 degrees
      let dx: CGFloat = viewRadius - viewRadius * cos(CGFloat(point) * angleSize + degrees2Rad(90.0) )
      let dy: CGFloat = viewRadius - viewRadius * sin(CGFloat(point) * angleSize + degrees2Rad(90.0) )

      */
      
      
      vertexPoints.append(CGPointMake(dx, dy))
    }
    
    return vertexPoints
  }
  
  
}
