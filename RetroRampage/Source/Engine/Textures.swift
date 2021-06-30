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
    case monsterAttack1, monsterAttack2, monsterAttack3, monsterAttack4, monsterAttack5
    case monsterAttack6, monsterAttack7, monsterAttack8, monsterAttack9, monsterAttack10
    case smg
    case smgFire1, smgFire2, smgFire3, smgFire4, smgFire5, smgFire6, smgFire7, smgFire8, smgFire9
    case monsterHurt1, monsterHurt2, monsterHurt3
    case monsterDeath1, monsterDeath2, monsterDeath3, monsterDeath4, monsterDeath5, monsterDeath6, monsterDeath7, monsterDeath8, monsterDeath9
    case monsterDead
    case door, door2
    case doorjamb, doorjamb2
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
