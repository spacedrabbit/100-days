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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    cloudView.startCloudEmitter()
  }
  
  
  // MARK: - Layout
  // ------------------------------------------------------------
  internal func configureConstraints() {
    self.sceneBackground.snp_makeConstraints { (make) -> Void in
      make.left.right.bottom.top.equalTo(self.view)
    }
    
    self.cloudView.snp_makeConstraints { (make) -> Void in
      make.left.top.right.equalTo(self.sceneBackground)
      make.bottom.equalTo(self.sceneBackground.snp_centerY)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.sceneBackground)
    self.sceneBackground.addSubview(cloudView)
  }
  
  
  // MARK: Lazy Inits
  // ------------------------------------------------------------
  internal lazy var sceneBackground: BackgroundView = BackgroundView(forTimeOfDay: .Afternoon)
  internal lazy var cloudView: CloudAnimationView = CloudAnimationView()
}
