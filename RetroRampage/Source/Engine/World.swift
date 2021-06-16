//
//  World.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import UIKit

public struct World
{
    public let map: Tilemap
    public var player: Player
    
    public init(map: Tilemap)
    {
        self.map = map
        self.player = Player(position: map.size / 2)
    }
}

public extension World
{
    var size: Vector
    {
        return map.size
    }
    mutating func update(timeStep: Double)
    {
        player.position += player.velocity * timeStep
        player.position.x.formTruncatingRemainder(dividingBy: size.x)
        player.position.y.formTruncatingRemainder(dividingBy: size.y)
    }
}
