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

    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = UIColor.whiteColor()
      
      let circle: CALayer = drawCircle(10.0, center: CGPointMake(200.0, 200.0))
      self.view.layer.addSublayer(circle)
      
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

}
