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
  
  fileprivate lazy var alignmentFrame: UIView = UIView()
  fileprivate lazy var circleView: UIView = UIView()
  fileprivate lazy var emitterView: UIView =  {
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
//    self.drawCircleInView(circleView)
//     self.setupEmitterInView(emitterView)
    self.setupExplosionEmitterInView(emitterView)
  }
  
  
  internal func drawCircleInView(_ view: UIView) {
    
    let circlePath: UIBezierPath = UIBezierPath(ovalIn: view.frame)
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = ColorSwatch.sr_mediumTeal.cgColor
    shapeLayer.lineWidth = 2.0
    shapeLayer.strokeColor = ColorSwatch.sr_mintGreen.cgColor
    
    view.layer.addSublayer(shapeLayer)
  }
  
  internal func setupExplosionEmitterInView(_ view: UIView) {
    
    let emitterLayer: CAEmitterLayer = CAEmitterLayer()
    emitterLayer.emitterPosition = view.center
    emitterLayer.emitterShape = kCAEmitterLayerSphere
    emitterLayer.emitterSize = CGSize(width: 10.0, height: 10.0) // space where an emitter cell could orignate from
    
    let blue = self.makeExplosionCellWithColor(ColorSwatch.sr_hipsterBlueBlack)
    let red = self.makeExplosionCellWithColor(ColorSwatch.sr_darkChalkGreen)
    let yellow = self.makeExplosionCellWithColor(ColorSwatch.sr_mediumTeal)
    let other = self.makeExplosionCellWithColor(UIColor.red)
    emitterLayer.emitterCells = [blue, red, yellow, other]
    
    view.layer.addSublayer(emitterLayer)
  }
  
  internal func makeExplosionCellWithColor(_ color: UIColor) -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.scale = 1.0
    cell.birthRate = 15
    cell.lifetime = 7.0
    cell.color = color.cgColor
    cell.velocity = 100
    cell.velocityRange = 0
    cell.scaleRange = 2.0
    cell.spin = 2.0
    cell.spinRange = 2.0
    cell.alphaSpeed = 2.0
    cell.alphaRange = 4.0
    cell.emissionLongitude = CGFloat(0.0)
    cell.emissionLatitude = CGFloat(M_PI)
    cell.emissionRange = CGFloat(M_PI) * 2.0
    
//    cell.contents = UIImage(named: "cat_icon")?.CGImage
    cell.contents = UIImage(named: "exclamation")?.cgImage

    return cell
  }
  
  internal func setupEmitterInView(_ view: UIView) {
    
    let emitterLayer: CAEmitterLayer = CAEmitterLayer()
    emitterLayer.emitterPosition = view.center
    emitterLayer.emitterShape = kCAEmitterLayerCircle

    
    let blue = makeEmitterCellWithColor(UIColor.blue)
    emitterLayer.emitterCells = [blue]
    
    view.layer.addSublayer(emitterLayer)
  }
  
  func makeEmitterCellWithColor(_ color: UIColor) -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.birthRate = 3
    cell.lifetime = 7.0
    cell.lifetimeRange = 0
    cell.color = color.cgColor
    cell.velocity = 200
    cell.velocityRange = 50
    cell.emissionLongitude = CGFloat(M_PI)
    cell.emissionRange = CGFloat(M_PI)
    cell.spin = 2
    cell.spinRange = 3
    cell.scaleRange = 0.1
    cell.scaleSpeed = -0.05
    
    cell.contents = UIImage(named: "cat_icon")?.cgImage
    return cell
  }
  
  internal func configureConstraints() {
    
    self.alignmentFrame.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.height.width.equalTo(140.0)
    }
    
    self.circleView.snp.makeConstraints { (make) -> Void in
      make.edges.height.width.equalTo(self.alignmentFrame)
    }
    
    self.emitterView.snp.makeConstraints { (make) -> Void in
      make.edges.height.width.equalTo(self.alignmentFrame)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(alignmentFrame)
    self.alignmentFrame.addSubview(circleView)
    self.alignmentFrame.addSubview(emitterView)
    
  }
  
}
