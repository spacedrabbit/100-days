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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    cloudView.startCloudEmitter()
  }
  
  
  // MARK: - Layout
  // ------------------------------------------------------------
  internal func configureConstraints() {
    self.sceneBackground.snp.makeConstraints { (make) -> Void in
      make.left.right.top.equalTo(self.view)
      make.height.equalTo(200.0)
    }
    
    self.cloudView.snp.makeConstraints { (make) -> Void in
      make.left.top.right.equalTo(self.sceneBackground)
      make.bottom.equalTo(self.sceneBackground.snp.centerY)
    }
    
    self.sunView.snp.makeConstraints { (make) -> Void in
      make.width.height.equalTo(70.0)
      make.left.equalTo(self.sceneBackground).offset(44.0)
      make.top.equalTo(self.sceneBackground).offset(24.0)
    }
    
    self.vanView.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(self.sceneBackground.groundView.snp.top)
      make.left.equalTo(self.sunView.snp.centerX)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.sceneBackground)
    self.sceneBackground.addSubviews([sunView, cloudView, vanView])
  }
  
  
  // MARK: Lazy Inits
  // ------------------------------------------------------------
  internal lazy var sceneBackground: BackgroundView = BackgroundView(forTimeOfDay: .afternoon)
  internal lazy var cloudView: CloudAnimationView = CloudAnimationView()
  internal lazy var sunView: TheSunView = TheSunView()
  internal lazy var vanView: DeliveryVanView = {
    let view: DeliveryVanView = DeliveryVanView()
    view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    return view
  }()
}
