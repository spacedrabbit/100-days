//
//  Day4ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/24/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class TappableCircleButton: UIControl {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    self.userInteractionEnabled = true
    self.addTarget(self, action: "buttonTouched:", forControlEvents: .TouchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func drawRect(rect: CGRect) {
    let circlePath: UIBezierPath = UIBezierPath(roundedRect: CGRectInset(rect, 4.0, 4.0), cornerRadius: rect.height/2.0)
    let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    circleShapeLayer.path = circlePath.CGPath
    circleShapeLayer.strokeColor = UIColor.blueColor().CGColor
    circleShapeLayer.fillColor = UIColor.yellowColor().CGColor
    circleShapeLayer.lineCap = kCALineCapSquare
    circleShapeLayer.lineWidth = 4.0
    
    let horizontalLinePath: UIBezierPath = UIBezierPath()
    horizontalLinePath.moveToPoint(CGPointMake(12.0, CGRectGetMidY(rect)))
    horizontalLinePath.addLineToPoint(CGPointMake(CGRectGetMaxX(rect) - 12.0, CGRectGetMidY(rect)))
    horizontalLinePath.closePath()
    let horizontalLineShapeLayer: CAShapeLayer = CAShapeLayer()
    horizontalLineShapeLayer.path = horizontalLinePath.CGPath
    horizontalLineShapeLayer.strokeColor = UIColor.redColor().CGColor
    horizontalLineShapeLayer.lineCap = kCALineCapSquare
    horizontalLineShapeLayer.lineWidth = 4.0
    
    let verticalLinePath: UIBezierPath = UIBezierPath()
    verticalLinePath.moveToPoint(CGPointMake(rect.width / 2.0, 12.0))
    verticalLinePath.addLineToPoint(CGPointMake(rect.width / 2.0, rect.height - 12.0))
    let verticalLineShapeLayer: CAShapeLayer = CAShapeLayer()
    verticalLineShapeLayer.path = verticalLinePath.CGPath
    verticalLineShapeLayer.strokeColor = UIColor.redColor().CGColor
    verticalLineShapeLayer.lineCap = kCALineCapSquare
    verticalLineShapeLayer.lineWidth = 4.0

    
    layer.addSublayer(circleShapeLayer)
    circleShapeLayer.addSublayer(horizontalLineShapeLayer)
    circleShapeLayer.addSublayer(verticalLineShapeLayer)
    
    circlePath.stroke()
    horizontalLinePath.stroke()
    verticalLinePath.stroke()
  }
  
  internal func buttonTouched(sender: AnyObject?) {
    print("TOUCHED")
  }
  
  override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    print("begin tracking?")
    return true
  }
  
  override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    print("continued tracking")
    return true
  }
  
  override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
    print("end tracking")
  }
  
//  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
////    print("touches began")
//  }
//  
//  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
////    print("touches moved")
//  }
//  
//  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
////    print("touches ended")
//  }
}

class Day4ViewController: UIViewController {
  
  lazy var contentView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.purpleColor()
    return view
  }()
  
  lazy var plusButton: TappableCircleButton = {
    var control: TappableCircleButton = TappableCircleButton()
    return control
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.configureButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func configureConstraints() {
    self.contentView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(100.0)
      make.leading.equalTo(self.view.snp_leading)
      make.trailing.equalTo(self.view.snp_trailing)
      make.centerY.equalTo(self.view.snp_centerY)
    }
    
    self.plusButton.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(50.0, 50.0))
      make.leading.equalTo(self.contentView.snp_leading).offset(15.0)
      make.top.equalTo(self.contentView.snp_top).offset(15.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.contentView)
    self.contentView.addSubview(self.plusButton)
  }
  
  internal func configureButton() {
    
  }
  
}
