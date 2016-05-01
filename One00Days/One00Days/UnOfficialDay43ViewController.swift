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
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.sceneBackground)
  }
  
  
  // MARK: Lazy Inits
  // ------------------------------------------------------------
  internal lazy var sceneBackground: BackgroundView = BackgroundView(forTimeOfDay: .Afternoon)
  
}
