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
    public let radius: Double = 0.25
    public let speed: Double = 2
    
    public init(position: Vector)
    {
        self.position = position
        self.velocity = Vector(x: 0, y: 0)
    }
}

public extension Player
{
    var rect: Rect
    {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }
    
    func intersection(with map: Tilemap) -> Vector?
    {
        let minimumX = Int(rect.min.x), maximumX = Int(rect.max.x)
        let minimumY = Int(rect.min.y), maximumY = Int(rect.max.y)
        var largestIntersection: Vector?
        for y in minimumY ... maximumY {
            for x in minimumX ... maximumX where map[x, y].isWall {
                let wallRect = Rect(
                    min: Vector(x: Double(x), y: Double(y)),
                    max: Vector(x: Double(x + 1), y: Double(y + 1))
                )
                if let intersection = rect.intersection(with: wallRect),
                    intersection.length > largestIntersection?.length ?? 0 {
                    largestIntersection = intersection
                }
            }
        }
        return largestIntersection
    }
}
