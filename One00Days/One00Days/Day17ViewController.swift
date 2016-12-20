//
//  Day17ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/8/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day17ViewController: UIViewController {
  
  lazy var foldingView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.yellow
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    
    setupViewHierarchy()
    configureConstraints()
    self.foldingView.layer.addSublayer(drawFoldingLayers())
    
    let currentBounds: CGRect = self.foldingView.layer.bounds
    
    self.foldingView.layer.transform = CATransform3DIdentity
    self.foldingView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    self.foldingView.layer.position = CGPoint(x: 0.0, y: -100.0)
    UIView.animate(withDuration: 2.0, animations: { () -> Void in
      self.foldingView.layer.transform = CATransform3DMakeRotation(degreesToRadians(75.0), 1.0, 0.0, 0.0)
      }, completion: { (complete: Bool) -> Void in
        
    }) 
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    foldingView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: 200.0, height: 200.0))
      make.center.equalTo(self.view.snp.center)
    }
    
    view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(foldingView)
  }
  
  internal func drawFoldingLayers() -> CALayer {
    let containerLayer: CALayer = CALayer()
    containerLayer.frame = self.foldingView.bounds
    
    let topPath: UIBezierPath = UIBezierPath(rect: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    let bottomPath: UIBezierPath = UIBezierPath(rect: CGRect(x: 0.0, y: 100.0, width: 100.0, height: 100.0))
    
    let topLayer: CAShapeLayer = CAShapeLayer()
    topLayer.path = topPath.cgPath
    topLayer.strokeColor = UIColor.purple.cgColor
    topLayer.fillColor = UIColor.red.cgColor
    topLayer.lineWidth = 3.0
    
    let bottomLayer: CAShapeLayer = CAShapeLayer()
    bottomLayer.path = bottomPath.cgPath
    bottomLayer.strokeColor = UIColor.blue.cgColor
    bottomLayer.fillColor = UIColor.red.cgColor
    bottomLayer.lineWidth = 3.0
    
    containerLayer.addSublayer(topLayer)
    containerLayer.addSublayer(bottomLayer)
    
    topPath.stroke()
    bottomPath.stroke()
    
    return containerLayer
  }
  
  internal func topFoldAnimation(_ layer: CALayer) {
    let fold: CATransform3D = CATransform3DMakeRotation(degreesToRadians(75.0), 1.0, 0.0, 0.0)
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.0) // top middle
    
    layer.transform = CATransform3DIdentity
    UIView.animate(withDuration: 3.0, animations: { () -> Void in
      layer.transform = fold
    }) 
  }
  
}
