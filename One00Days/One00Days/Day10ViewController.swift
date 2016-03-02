//
//  Day10ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/1/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class CubeGenerator {
  
  let standardSize: CGRect = CGRectMake(0.0, 0.0, 100.0, 100.0)
  
  internal class func createCubeWithColor(color: UIColor) {
    
    
    
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


class Day10ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  internal func configureConstraints() {
    
  }
  
  internal func setupViewHierarchy() {
    
  }

}
