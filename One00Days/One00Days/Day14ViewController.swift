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
    view.frame = CGRect(x: 0,y: 0,width: 200,height: 200)
    view.backgroundColor = UIColor.yellow
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
    let originPoint: CGPoint = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    
    let rightsideBezierPath: UIBezierPath = UIBezierPath()
    rightsideBezierPath.move(to: points[0])
    rightsideBezierPath.addLine(to: points[1])
    rightsideBezierPath.addLine(to: points[2])
    rightsideBezierPath.addLine(to: originPoint)
    rightsideBezierPath.close()
    
    let rightsideShapeLayer: CAShapeLayer = CAShapeLayer()
    rightsideShapeLayer.path = rightsideBezierPath.cgPath
    rightsideShapeLayer.strokeColor = color.cgColor
    rightsideShapeLayer.fillColor = color.cgColor
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
    self.cubeView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view.snp.center)
      make.size.equalTo(CGSize(width: 200.0, height: 200.0))
    }
    view.layoutIfNeeded()
    view.updateConstraintsIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.cubeView)
  }
  
}
