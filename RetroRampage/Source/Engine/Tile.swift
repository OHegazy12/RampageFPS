//
//  Tile.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//


public enum Tile: Int, Decodable
{
    case floor = 0
    case wall = 1
    case crackWall = 2
    case slimeWall = 3
    case crackFloor = 4
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
        case .crackWall:
            return true
        case .slimeWall:
            return true
        case .crackFloor:
            return false
        }
    }
    
    var textures: [Texture]
    {
        switch self
        {
        case .floor:
            return [.floor, .ceiling]
        case .crackFloor:
            return [.crackFloor, .ceiling]
        case .wall:
            return [.wall, .wall2]
        case .crackWall:
            return [.crackWall, .crackWall2]
        case .slimeWall:
            return [.slimeWall, .slimeWall2]
        }
    }
}
