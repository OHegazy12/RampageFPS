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
