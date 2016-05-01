//
//  BackgroundView.swift
//  One00Days
//
//  Created by Louis Tur on 4/30/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import SnapKit

internal enum SceneTimeOfDay {
  case Morning
  case Afternoon
  case Evening
}

internal struct SceneColor {
  internal struct Sky {
    internal static let Afternoon: UIColor = UIColor(red: 179.0/255.0, green: 229.0/255.0, blue: 252.0/255.0, alpha: 1.0)
  }
  
  internal struct Ground {
    internal static let Afternoon: UIColor = UIColor(red: 66.0/255.0, green: 133.0/255.0, blue: 244.0/255.0, alpha: 1.0)
  }
}

internal class BackgroundView: UIView {

  // MARK: - Variables
  // ------------------------------------------------------------
  internal var groundColor: UIColor!
  internal var skyColor: UIColor!

  
  // MARK: - Inits
  // ------------------------------------------------------------
  convenience init(forTimeOfDay timeOfDay: SceneTimeOfDay) {
    self.init(frame: CGRectZero)
    
    self.updateSceneForTimeOfDay(timeOfDay)
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - Helpers
  // ------------------------------------------------------------
  internal func updateSceneForTimeOfDay(timeOfDay: SceneTimeOfDay) {

    switch timeOfDay {
    case .Morning: print("not implemented")
      
    case .Afternoon:
      self.skyColor = SceneColor.Sky.Afternoon
      self.groundColor = SceneColor.Ground.Afternoon
      
    case .Evening: print("not implemented")
    }
    
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      self.skyView.backgroundColor = self.skyColor
      self.groundView.backgroundColor = self.groundColor
    }
  }
  
  
  // MARK: - Layout
  // ------------------------------------------------------------
  internal func configureConstraints() {
    self.skyView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self)
    }
    
    self.groundView.snp_makeConstraints { (make) -> Void in
      make.left.right.bottom.equalTo(self)
      make.height.equalTo(60.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.addSubviews([skyView, groundView])
  }
  
  
  // MARK: - Lazy Inits
  // ------------------------------------------------------------
  lazy var skyView: UIView = {
  let view: UIView = UIView()
  view.backgroundColor = SceneColor.Sky.Afternoon
  return view
  }()
  
  lazy var groundView: UIView = {
  let view: UIView = UIView()
  view.backgroundColor = SceneColor.Ground.Afternoon
  return view
  }()
  
  

}
