//
//  Day14ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/5/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day14ViewController: Day13ViewController {
  
  lazy var cubeView: UIView = {
    let view: UIView = UIView()
    view.frame = CGRectMake(0,0,200,200)
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
    
    let hexPoints: [CGPoint] = getPointsForHexagonPath(cubeView)
    print("\(hexPoints)")
    
    // no magic behind this. I drew the hex with getPointsForHexagonPath, printed each vertex and matched the position of
    // the vertex with where it would appear in the hexagon
    let rightSideHexPoints: [CGPoint] = [hexPoints[0], hexPoints[1], hexPoints[2]]
    let leftSideHexPoints: [CGPoint] = [hexPoints[2], hexPoints[3], hexPoints[4]]
    let topSideHexPoints: [CGPoint] = [hexPoints[4], hexPoints[5], hexPoints[0]]
    
    drawRightSideOfCube(withPoints: rightSideHexPoints, view: cubeView, color: ColorSwatch.sr_coolWhite)
    drawLeftSideOfCube(withPoints: leftSideHexPoints, view: cubeView, color: ColorSwatch.sr_darkChalkGreen)
    drawTopSideOfCube(withPoints: topSideHexPoints, view: cubeView, color:ColorSwatch.sr_mintGreen)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func drawRightSideOfCube(withPoints points: [CGPoint], view: UIView, color: UIColor) {
    let originPoint: CGPoint = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
    
    let rightsideBezierPath: UIBezierPath = UIBezierPath()
    rightsideBezierPath.moveToPoint(points[0])
    rightsideBezierPath.addLineToPoint(points[1])
    rightsideBezierPath.addLineToPoint(points[2])
    rightsideBezierPath.addLineToPoint(originPoint)
    rightsideBezierPath.closePath()
    
    let rightsideShapeLayer: CAShapeLayer = CAShapeLayer()
    rightsideShapeLayer.path = rightsideBezierPath.CGPath
    rightsideShapeLayer.strokeColor = color.CGColor
    rightsideShapeLayer.fillColor = color.CGColor
    rightsideShapeLayer.lineWidth = 2.0
    
    view.layer.addSublayer(rightsideShapeLayer)
    rightsideBezierPath.stroke()
    
  }
  
  internal func drawLeftSideOfCube(withPoints points: [CGPoint], view: UIView, color: UIColor) {
    drawRightSideOfCube(withPoints: points, view: view, color: color)
  }
  
  internal func drawTopSideOfCube(withPoints points: [CGPoint], view: UIView, color: UIColor) {
    drawRightSideOfCube(withPoints: points, view: view, color: color)
  }
  
  internal func configureConstraints() {
    self.cubeView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view.snp_center)
      make.size.equalTo(CGSizeMake(200.0, 200.0))
    }
    view.layoutIfNeeded()
    view.updateConstraintsIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.cubeView)
  }
  
}
