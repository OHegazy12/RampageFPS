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
    
    public init(width: Int, pixels: [Color])
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
            pixels[y * width + x] = newValue
                }
            }
    
    init(width: Int, height: Int, color: Color) {
        self.pixels = Array(repeating: color, count: width * height)
        self.width = width
}
    mutating func fill(rect: Rect, color: Color) {
        for y in Int(rect.min.y) ..< Int(rect.max.y) {
            for x in Int(rect.min.x) ..< Int(rect.max.x) {
                self[x, y] = color
            }
        }
}
    mutating func drawColumn(_ sourceX: Int, of source: Bitmap, at point: Vector, height: Double)
    {
        let start = Int(point.y), end = Int((point.y + height).rounded(.up))
        let stepY = Double(source.height) / height
        for y in max (0, start) ..< min(self.height, end)
        {
            let sourceY = max(0, Double(y) - point.y) * stepY
            let sourceColor = source[sourceX, Int(sourceY)]
            self[Int(point.x), y] = sourceColor
        }
    }
}

