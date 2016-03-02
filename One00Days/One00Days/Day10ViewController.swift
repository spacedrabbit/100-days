//
//  Day10ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/1/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import Foundation

class CubeGenerator {
  
  let standardSize: CGRect = CGRectMake(0.0, 0.0, 100.0, 100.0)
  
  internal class func createCubeWithColor(color: UIColor) -> UIView {
    let view: UIView = UIView(frame: CubeGenerator().standardSize)
    view.layer.addSublayer(CubeGenerator().drawCube(color))
    return view
  }
  
  internal func drawCube(color: UIColor) -> CALayer{
    
    let path: UIBezierPath = UIBezierPath(roundedRect: standardSize, byRoundingCorners: [.TopLeft, .BottomRight], cornerRadii: CGSizeMake(10.0, 10.0))
    path.lineWidth = 4.0
    
    let layer: CAShapeLayer = CAShapeLayer()
    layer.frame = standardSize
    layer.fillColor = color.CGColor
    layer.strokeColor = UIColor.blackColor().CGColor
    layer.path = path.CGPath
    
    path.fill()
    return layer
  }
}

class Animator {
  internal class func animateWithUpwardsSpring(cube: UIView) {
    let currentFrame: CGRect = cube.frame
    let minimumDistanceToCover: CGFloat = 500.0
    
    let xCoordRandomize: CGFloat = CGFloat(NSNumber(unsignedInt: arc4random_uniform(99) + 1).doubleValue / 100.0) * 356.0
    let yCoordRandomize: CGFloat = CGFloat(NSNumber(unsignedInt: arc4random_uniform(99) + 1).doubleValue) + minimumDistanceToCover
    
    print("\(xCoordRandomize), \(yCoordRandomize)")
    UIView.animateWithDuration(2.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: .BeginFromCurrentState, animations: { () -> Void in
      
      let shiftedX: CGFloat = xCoordRandomize
      let shiftedY: CGFloat = yCoordRandomize + currentFrame.origin.y
      let newFrame: CGRect = CGRectMake(shiftedX, 568.0 - shiftedY, currentFrame.size.width, currentFrame.size.height)
      
      cube.frame = newFrame
      
      }) { (complete: Bool) -> Void in
        print("Done animating")
    }
  }
}


class Day10ViewController: UIViewController {
  
  lazy var button: UIButton = {
    let button: UIButton = UIButton(frame: CGRectMake(10.0, 30.0, 200.0, 100.0))
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.whiteColor()
//    self.view.addSubview(self.button)
    self.button.backgroundColor = UIColor.redColor()
    self.button.setTitle("PRESS", forState: .Normal)
    self.button.addTarget(self, action: "fireCube", forControlEvents: UIControlEvents.TouchUpInside)
    
    let timer: NSTimer = NSTimer(timeInterval: 0.25, target: self, selector: "fireCube", userInfo: nil, repeats: true)
    NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func fireCube() {
    let cube: UIView = CubeGenerator.createCubeWithColor(UIColor.redColor())
    self.view.addSubview(cube)
    cube.frame = CGRectMake(CGRectGetMidX(cube.frame), CGRectGetMaxY(self.view.frame) + 100.0, 100.0, 100.0)
    Animator.animateWithUpwardsSpring(cube)
  }
  
  internal func configureConstraints() {
    
  }
  
  internal func setupViewHierarchy() {
    
  }
  
}
