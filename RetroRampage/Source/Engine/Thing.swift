//
//  Thing.swift
//  Engine
//
//  Created by Omar Hegazy on 6/16/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

public enum Thing: Int, Decodable
{
    case nothing
    case player
    case monster
    case door
    case pushwall
    case `switch`
}
