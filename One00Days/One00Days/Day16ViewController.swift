//
//  Day16ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/7/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day16ViewController: UIViewController {
  
  let hexHelper: HexCube = HexCube()
  lazy var hexView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.yellow
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    
    setupViewHierarchy()
    configureConstraints()
    drawHex()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func drawHex() {
    hexHelper.vertexPointsForHexCube(withOrigin: CGPoint(x: self.hexView.bounds.midX, y: self.hexView.bounds.midY), radius:(self.hexView.frame.width / 2.0))
    hexHelper.drawDefaultHexCube(inView: self.hexView)
  }
  
  internal func configureConstraints() {
    self.hexView.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: 200.0, height: 200.0))
      make.center.equalTo(self.view.snp.center)
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(hexView)
  }
  
}
