//
//  Door.swift
//  Engine
//
//  Created by Omar Hegazy on 6/28/21.

public enum DoorState {
    case closed
    case opening
    case open
    case closing
}

public struct Door {
    public let duration: Double = 0.5
    public let closeDelay: Double = 3
    public let position: Vector
    public let direction: Vector
    public let texture: Texture
    public var state: DoorState = .closed
    public var time: Double = 0

    public init(position: Vector, isVertical: Bool) {
        self.position = position
        if isVertical {
            self.direction = Vector(x: 0, y: 1)
            self.texture = .door
        } else {
            self.direction = Vector(x: 1, y: 0)
            self.texture = .door2
        }
    }
}

public extension Door {
    var rect: Rect {
        let position = self.position + direction * (offset - 0.5)
        return Rect(min: position, max: position + direction)
    }

    var offset: Double {
        let t = min(1, time / duration)
        switch state {
        case .closed:
            return 0
        case .opening:
            return Easing.easeInEaseOut(t)
        case .open:
            return 1
        case .closing:
            return 1 - Easing.easeInEaseOut(t)
        }
    }

    var billboard: Billboard {
        return Billboard(
            start: position + direction * (offset - 0.5),
            direction: direction,
            length: 1,
            texture: texture
        )
    }

    func hitTest(_ ray: Ray) -> Vector? {
        return billboard.hitTest(ray)
    }

    mutating func update(in world: inout World) {
        switch state {
        case .closed:
            if world.player.intersection(with: self) != nil {
                state = .opening
                time = 0
            }
        case .opening:
            if time >= duration {
                state = .open
                time = 0
            }
        case .open:
            if time >= closeDelay {
                state = .closing
                time = 0
            }
        case .closing:
            if time >= duration {
                state = .closed
                time = 0
            }
        }
    }
}
