//
//  HexShapes.swift
//  One00Days
//
//  Created by Louis Tur on 3/6/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

struct ColorSwatch {
  static let sr_coolWhite: UIColor = UIColor(red: (252/255.0), green: 1.0, blue: (245.0/255.0), alpha: 1.0)
  static let sr_darkChalkGreen: UIColor = UIColor(red: (145.0/255.0), green: (170.0/255.0), blue: (157.0/255.0), alpha: 1.0)
  static let sr_mintGreen: UIColor = UIColor(red: (209/255.0), green: (219.0/255/0), blue: (189.0/255.0), alpha: 1.0)
}

typealias HexPoints = [CGPoint]
class HexCube {
  static let numberOfVertices: Int = 6
  let vertexPoints: HexPoints = []
  
  internal func vertexPointsForHexCube(withOrigin origin: CGPoint, radius: CGFloat) -> HexPoints{
    var points: HexPoints = []
    let center: CGPoint = origin
    let radius: CGFloat = radius
    let angleSize: CGFloat = deg2Rad((360.0 / CGFloat(HexCube.numberOfVertices)))
    let rotationAdjustment: CGFloat = deg2Rad(90.0) // rotates hex a bit for stylistic purpose
    
    for vertex in 1...HexCube.numberOfVertices {
      let dx: CGFloat = center.x - radius * cos(CGFloat(vertex) * angleSize + rotationAdjustment)
      let dy: CGFloat = center.y - radius * sin(CGFloat(vertex) * angleSize + rotationAdjustment)
      
      points.append(CGPointMake(dx, dy))
    }
    
    return points
  }
  
  private func deg2Rad(degrees: CGFloat) -> CGFloat {
    return CGFloat(M_PI) * degrees/180.0
  }
}
