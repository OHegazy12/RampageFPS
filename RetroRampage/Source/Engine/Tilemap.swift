//
//  Tilemap.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import UIKit

public struct Tilemap: Decodable
{
    private let tiles: [Tile]
    public let width: Int
    public let things: [Thing]
}

public extension Tilemap
{
    var height: Int
    {
        return tiles.count / width
    }
    
    var size: Vector
    {
        return Vector(x: Double(width), y: Double(height))
    }
    
    subscript(x: Int, y: Int) -> Tile
    {
        return tiles[y * width + x]
    }
    
    func hitTest(_ ray: Ray) -> Vector
    {
        var position = ray.origin
        let edgeDistanceX, edgeDistanceY: Double
        if ray.direction.x > 0
        {
            edgeDistanceX = position.x.rounded(.down) + 1 - position.x
        }
        else
        {
            edgeDistanceX = position.x.rounded(.up) - 1 - position.x
        }
        if ray.direction.y > 0
        {
            edgeDistanceY = position.y.rounded(.down) + 1 - position.y
        }
        else
        {
            edgeDistanceY = position.y.rounded(.up) - 1 - position.y
        }
        let slope = ray.direction.x / ray.direction.y
        let step1 = Vector(x: edgeDistanceX, y: edgeDistanceX / slope)
        let step2 = Vector(x: edgeDistanceY * slope, y: edgeDistanceY)
        
        if step1.length < step2.length
        {
            position += step1
        }
        else
        {
            position += step2
        }
        return position
    }
}

