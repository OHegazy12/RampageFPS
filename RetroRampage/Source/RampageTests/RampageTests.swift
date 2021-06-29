//
//  RampageTests.swift
//  RampageTests
//
//  Created by Omar Hegazy on 6/27/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import XCTest
import Engine
import Rampage

class RampageTests: XCTestCase
{
    let world = World(map: loadMap())
    let textures = loadTextures()
    
    func testRenderFrame()
    {
        self.measure {
            var renderer = Renderer(width: 1000, height: 1000, textures: textures)
            renderer.draw(world)
        }
    }
}

