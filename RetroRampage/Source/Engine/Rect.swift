//
//  Rect.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import UIKit

public struct Rect
{
    var min, max: Vector
    
    public init(min: Vector, max: Vector)
    {
        self.min = min
        self.max = max
    }
}
