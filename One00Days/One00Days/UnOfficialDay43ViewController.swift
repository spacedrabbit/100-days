//
//  UnOfficialDay43ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 4/30/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import SnapKit

class UnOfficialDay43ViewController: UIViewController {
  
  
  // MARK: - View Lifecycle
  // ------------------------------------------------------------
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }

  
  // MARK: - Layout
  // ------------------------------------------------------------
  internal func configureConstraints() {
    self.sceneBackground.snp_makeConstraints { (make) -> Void in
      make.left.right.bottom.top.equalTo(self.view)
    }
    
    self.cloudView.snp_makeConstraints { (make) -> Void in
      make.left.top.equalTo(self.sceneBackground)
      make.bottom.equalTo(self.sceneBackground.snp_centerY)
      make.right.equalTo(self.sceneBackground.snp_centerX)
    }
  }
  
  internal func setupViewHierarchy() {
//    cloudView.backgroundColor = UIColor.purpleColor()
    
    self.view.addSubview(self.sceneBackground)
    self.sceneBackground.addSubview(cloudView)
  }
  
  
  // MARK: Lazy Inits
  // ------------------------------------------------------------
  internal lazy var sceneBackground: BackgroundView = BackgroundView(forTimeOfDay: .Afternoon)
  internal lazy var cloudView: CloudAnimationView = CloudAnimationView()
}
