//
//  Ray.swift
//  Engine
//
//  Created by Omar Hegazy on 6/17/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import UIKit

public struct Ray
{
    public var origin, direction: Vector
    
    public init(origin: Vector, direction: Vector)
    {
        self.origin = origin
        self.direction = direction
    }
}
