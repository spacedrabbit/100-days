//
//  UnOfficialDay42ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 4/25/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import SnapKit

class UnOfficialDay42ViewController: UIViewController {
  
  private lazy var alignmentFrame: UIView = UIView()
  private lazy var circleView: UIView = UIView()
  private lazy var emitterView: UIView =  {
    let view: UIView = UIView()
    view.clipsToBounds = false
    return view
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorSwatch.sr_coolWhite
    
    self.setupViewHierarchy()
    self.configureConstraints()
   
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
//    self.drawCircleInView(circleView)
     self.setupEmitterInView(emitterView)
  }
  
  
  internal func drawCircleInView(view: UIView) {
    
    let circlePath: UIBezierPath = UIBezierPath(ovalInRect: view.frame)
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.CGPath
    shapeLayer.fillColor = ColorSwatch.sr_mediumTeal.CGColor
    shapeLayer.lineWidth = 2.0
    shapeLayer.strokeColor = ColorSwatch.sr_mintGreen.CGColor
    
    view.layer.addSublayer(shapeLayer)
  }
  
  internal func setupEmitterInView(view: UIView) {
    
    let emitterLayer: CAEmitterLayer = CAEmitterLayer()
//    emitterLayer.emitterPosition = view.center
//    emitterLayer.emitterShape = kCAEmitterLayerCircle
//    emitterLayer.emitterSize = CGSizeMake(view.frame.width/2.0, view.frame.height/2.0)
    
    emitterLayer.emitterPosition = CGPoint(x: view.center.x, y: -96)
    emitterLayer.emitterShape = kCAEmitterLayerLine
    emitterLayer.emitterSize = CGSize(width: view.frame.size.width, height: 1)
    
    let blue = makeEmitterCellWithColor(UIColor.blueColor())
    emitterLayer.emitterCells = [blue]
    
    view.layer.addSublayer(emitterLayer)
  }
  
  func makeEmitterCellWithColor(color: UIColor) -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.birthRate = 3
    cell.lifetime = 7.0
    cell.lifetimeRange = 0
    cell.color = color.CGColor
    cell.velocity = 200
    cell.velocityRange = 50
    cell.emissionLongitude = CGFloat(M_PI)
    cell.emissionRange = CGFloat(M_PI_4)
    cell.spin = 2
    cell.spinRange = 3
    cell.scaleRange = 0.5
    cell.scaleSpeed = -0.05
    
    cell.contents = UIImage(named: "cat_icon")?.CGImage
    return cell
  }
  
  internal func configureConstraints() {
    
    self.alignmentFrame.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.height.width.equalTo(140.0)
    }
    
    self.circleView.snp_makeConstraints { (make) -> Void in
      make.edges.height.width.equalTo(self.alignmentFrame)
    }
    
    self.emitterView.snp_makeConstraints { (make) -> Void in
      make.edges.height.width.equalTo(self.alignmentFrame)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(alignmentFrame)
    self.alignmentFrame.addSubview(circleView)
    self.alignmentFrame.addSubview(emitterView)
    
  }
  
}
