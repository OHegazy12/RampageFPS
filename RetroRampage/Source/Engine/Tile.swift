//
//  Tile.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.

public enum Tile: Int, Decodable {
    case floor
    case wall
    case crackWall
    case slimeWall
    case crackFloor
    case elevatorFloor
    case elevatorSideWall
    case elevatorBackWall
}

public extension Tile {
    var isWall: Bool {
        switch self {
        case .wall, .crackWall, .slimeWall, .elevatorSideWall, .elevatorBackWall:
            return true
        case .floor, .crackFloor, .elevatorFloor:
            return false
        }
    }

    var textures: [Texture] {
        switch self {
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
        case .elevatorSideWall:
            return [.elevatorSideWall, .elevatorSideWall]
        case .elevatorBackWall:
            return [.elevatorBackWall, .elevatorBackWall]
        case .elevatorFloor:
            return [.elevatorFloor, .elevatorCeiling]
        }
    }
}
