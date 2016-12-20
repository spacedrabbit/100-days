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
  
  static let standardSize: CGRect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
  
  internal class func createCubeWithColor(_ color: UIColor) -> UIView {
    let view: UIView = UIView(frame: CubeGenerator.standardSize)
    view.layer.addSublayer(CubeGenerator().drawCube(color))
    return view
  }
  
  internal func drawCube(_ color: UIColor) -> CALayer{
    
    let path: UIBezierPath = UIBezierPath(roundedRect: CubeGenerator.standardSize, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
    path.lineWidth = 4.0
    
    let layer: CAShapeLayer = CAShapeLayer()
    layer.frame = CubeGenerator.standardSize
    layer.fillColor = color.cgColor
    layer.strokeColor = UIColor.black.cgColor
    layer.path = path.cgPath
    
//    path.fill()
    return layer
  }
}

class Animator {
  internal class func animateWithUpwardsSpring(_ cube: UIView) {
    let currentFrame: CGRect = cube.frame
    let minimumDistanceToCover: CGFloat = 500.0
    
    let xCoordRandomize: CGFloat = CGFloat(NSNumber(value: arc4random_uniform(99) + 1 as UInt32).doubleValue / 100.0) * 356.0
    let yCoordRandomize: CGFloat = CGFloat(NSNumber(value: arc4random_uniform(99) + 1 as UInt32).doubleValue) + minimumDistanceToCover
    
    print("\(xCoordRandomize), \(yCoordRandomize)")
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: .beginFromCurrentState, animations: { () -> Void in
      
      let shiftedX: CGFloat = xCoordRandomize
      let shiftedY: CGFloat = yCoordRandomize + currentFrame.origin.y
      let newFrame: CGRect = CGRect(x: shiftedX, y: 568.0 - shiftedY, width: currentFrame.size.width, height: currentFrame.size.height)
      
      cube.frame = newFrame
      
      }) { (complete: Bool) -> Void in
        print("Done animating")
    }
  }
}


class Day10ViewController: UIViewController {
  
  lazy var button: UIButton = {
    let button: UIButton = UIButton(frame: CGRect(x: 10.0, y: 30.0, width: 200.0, height: 100.0))
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.white
//    self.view.addSubview(self.button)
    self.button.backgroundColor = UIColor.red
    self.button.setTitle("PRESS", for: UIControlState())
    self.button.addTarget(self, action: #selector(Day10ViewController.fireCube), for: UIControlEvents.touchUpInside)
    
    let timer: Timer = Timer(timeInterval: 1.35, target: self, selector: #selector(Day10ViewController.fireCube), userInfo: nil, repeats: true)
    RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func fireCube() {
    let cube: UIView = CubeGenerator.createCubeWithColor(self.randomColor())
    self.view.addSubview(cube)
    cube.frame = CGRect(x: cube.frame.midX, y: self.view.frame.maxY + 100.0, width: 100.0, height: 100.0)
    Animator.animateWithUpwardsSpring(cube)
  }
  
  internal func randomColor() -> UIColor {
    let r: CGFloat = CGFloat(arc4random_uniform(99) + 1)/100.0
    let g: CGFloat = CGFloat(arc4random_uniform(99) + 1)/100.0
    let b: CGFloat = CGFloat(arc4random_uniform(99) + 1)/100.0
    
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }
  
}
