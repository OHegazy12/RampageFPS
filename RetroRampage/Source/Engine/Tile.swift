//
//  Tile.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//


public enum Tile: Int, Decodable
{
    case floor
    case wall
}

public extension Tile
{
    var isWall: Bool
    {
        switch self
        {
        case .wall:
            return true
        case .floor:
            return false
        }
    }
}
