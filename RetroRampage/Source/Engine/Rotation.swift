//
//  Rotation.swift
//  Engine
//
//  Created by Omar Hegazy on 6/18/21.

public struct Rotation {
    var m1, m2, m3, m4: Double
}

public extension Rotation {
    init(sine: Double, cosine: Double) {
        self.init(m1: cosine, m2: -sine, m3: sine, m4: cosine)
    }
}

public extension Vector {
    func rotated(by rotation: Rotation) -> Vector {
        return Vector(
            x: x * rotation.m1 + y * rotation.m2,
            y: x * rotation.m3 + y * rotation.m4
        )
    }
}
