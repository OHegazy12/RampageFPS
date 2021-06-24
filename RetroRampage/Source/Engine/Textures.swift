//
//  Textures.swift
//  Engine
//
//  Created by Omar Hegazy on 6/19/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

public enum Texture: String, CaseIterable
{
    case wall, wall2
    case floor, ceiling
    case crackWall, crackWall2
    case slimeWall, slimeWall2
    case crackFloor
    case monster
    case monsterWalk1, monsterWalk2, monsterWalk3, monsterWalk4, monsterWalk5, monsterWalk6, monsterWalk7, monsterWalk8
    case monsterAttack1, monsterAttack2, monsterAttack3, monsterAttack4, monsterAttack5, monsterAttack6, monsterAttack7, monsterAttack8, monsterAttack9, monsterAttack10
}

public struct Textures
{
    private let textures: [Texture: Bitmap]
}

public extension Textures
{
    init(loader: (String) -> Bitmap)
    {
        var textures = [Texture: Bitmap]()
        for texture in Texture.allCases
        {
            textures[texture] = loader(texture.rawValue)
        }
        self.init(textures: textures)
    }
    subscript(_ texture: Texture) -> Bitmap
    {
        return textures[texture]!
    }
}
