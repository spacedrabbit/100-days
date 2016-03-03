//
//  StarNode.swift
//  IntroSpriteKit
//
//  Created by Louis Tur on 3/2/16.
//  Copyright © 2016 SRLabs. All rights reserved.
// https://spin.atomicobject.com/2014/12/29/spritekit-physics-tutorial-swift/

import Foundation
import UIKit
import SpriteKit

class StarNode: SKSpriteNode {
  class func star(location: CGPoint) -> StarNode {
    let starSprite: StarNode = StarNode(imageNamed: "star.png")
    starSprite.xScale = 0.075
    starSprite.yScale = 0.075
    starSprite.position = location
    
    starSprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "star.png"), size: starSprite.size)
    if let physics = starSprite.physicsBody {
      physics.affectedByGravity = true
      physics.allowsRotation = true
      physics.dynamic = true
      physics.linearDamping = 0.75
      physics.angularDamping = 0.75
      physics.restitution = 0.5
    }
    return starSprite
  }
  
}