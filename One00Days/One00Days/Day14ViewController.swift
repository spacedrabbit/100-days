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
    
    
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func configureConstraints() {
    self.cubeView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view.snp_center)
      make.size.equalTo(CGSizeMake(200.0, 200.0))
    }
    view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.cubeView)
  }
  
}
