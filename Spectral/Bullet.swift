//
//  Bullet.swift
//  Spectral
//
//  Created by Forrest on 7/9/17.
//  Copyright © 2017 Forrest. All rights reserved.
//

import UIKit
import SceneKit

//Sphere placeholder for now
class Bullet: SCNNode {
    override init () {
        super.init()
        let sphere = SCNSphere(radius: 0.025)
        self.geometry = sphere
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.bullets.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.enemy.rawValue
    }
}
