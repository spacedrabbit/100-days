//
//  Day23ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/14/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day23ViewController: UIViewController {
  
  let radarView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = ColorSwatch.sr_hipsterBlueBlack
    return view
  }()
  
  let progress: CircularProgressView = {
    let view: CircularProgressView = CircularProgressView(frame: CGRect(x: 0,y: 0,width: 200,height: 200))
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    
    
    
    self.setupViewHierarchy()
    self.configureConstraints()
    drawVerticalGreenLineIn(view: self.radarView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  internal func drawVerticalGreenLineIn(view: UIView) {
    let midPoint: CGPoint = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    let radius: CGFloat = fmax(view.bounds.width, view.bounds.height) / 2.0
    
    let linePath: UIBezierPath = UIBezierPath()
    linePath.move(to: midPoint)
    linePath.addLine(to: CGPoint(x: midPoint.x, y: midPoint.y + radius))
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    shapeLayer.path = linePath.cgPath
    shapeLayer.lineWidth = 5.0
    shapeLayer.strokeColor = ColorSwatch.sr_hipsterOlive.cgColor
    shapeLayer.fillColor = UIColor.clear.cgColor
    
    view.layer.addSublayer(shapeLayer)
    
//    UIView.animateKeyframesWithDuration(3.0, delay: 0.0, options: [.Repeat, .CalculationModePaced, .BeginFromCurrentState], animations: { () -> Void in
//      
//      view.layer.transform = CATransform3DIdentity
//      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: { () -> Void in
//        view.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0)
//      })
//      
//      UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: { () -> Void in
//        view.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2 * 2), 0.0, 0.0, 1.0)
//      })
//      
//      UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.25, animations: { () -> Void in
//        view.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2 * 3), 0.0, 0.0, 1.0)
//      })
//      
//      UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25, animations: { () -> Void in
//        view.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2 * 4), 0.0, 0.0, 1.0)
//      })
//      
//      }) { (complete: Bool) -> Void in
//    }
  }
  
  internal func configureConstraints() {
    self.radarView.snp.makeConstraints { (make) -> Void in
      make.left.right.centerY.equalTo(self.view)
      make.height.equalTo(self.view.bounds.width)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(radarView)
  }
  
}
