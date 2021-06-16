//
//  Player.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import UIKit

public struct Player
{
    public var position: Vector
    public var velocity: Vector
    public let radius: Double = 0.5
    
    public init(position: Vector)
    {
        self.position = position
        self.velocity = Vector(x: 1, y: 1)
    }
}

public extension Player
{
    var rect: Rect
    {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }
}
