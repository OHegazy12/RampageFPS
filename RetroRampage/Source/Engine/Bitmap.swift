//
//  Bitmap.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

import UIKit

public struct Bitmap
{
    public private(set) var pixels: [Color]
    public let width: Int
    
    public init(width: Int, pixels: [Color], height: Int)
    {
        self.width = width
        self.pixels = pixels
    }
}


public extension Bitmap
{
    var height: Int
    {
        let bitmapheight = pixels.count / width
        return bitmapheight
    }
    subscript(x: Int, y: Int) -> Color
    {
        get { return pixels[y * width + x] }
        set {
            guard x >= 0, y >= 0, x < width, y < height else {
                return
            }
            pixels[y * width + x] = newValue}
            }
    
    init(width: Int, height: Int, color: Color) {
        self.pixels = Array(repeating: color, count: width * height)
        self.width = width
}
    mutating func fill(rect: Rect, color: Color)
    {
        for y in Int(rect.minY) ..< Int(rect.maxY)
        {
          for x in Int(rect.minX) ..< Int(rect.maxX)
          {
                self[x, y] = color
            }
        }
    }
    
    mutating func drawLine(from: Vector, to: Vector, color: Color)
    {
        let difference = to - from
        let stepCount: Int
        let step: Vector
        if abs(difference.x) > abs(difference.y)
        {
            stepCount = Int(abs(difference.x).rounded(.up))
            let sign = difference.x > 0 ? 1.0 : -1.0
            step = Vector(x: 1, y: difference.y / difference.x) * sign
        }
        else
        {
            stepCount = Int(abs(difference.y).rounded(.up))
            let sign = difference.y > 0 ? 1.0 : -1.0
            step = Vector(x: difference.x / difference.y, y: 1) * sign
        }
        var point = from
        for _ in 0 ..< stepCount
        {
        self[Int(point.x), Int(point.y)] = color
        point += step
        }
    }
}

public extension Rect {
    var minX: Double {Swift.min(min.x, max.x)}
    var maxX: Double {Swift.max(min.x, max.x)}
    var minY: Double {Swift.min(min.y, max.y)}
    var maxY: Double {Swift.max(min.y, max.y)}
}
