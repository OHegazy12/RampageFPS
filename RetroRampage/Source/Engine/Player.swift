//
//  Player.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

public enum PlayerState
{
    case idle
    case firing
}
public struct Player: Actor {
    public let speed: Double = 3
    public let turningSpeed: Double = .pi
    public let radius: Double = 0.25
    public var position: Vector
    public var velocity: Vector
    public var direction: Vector
    public var health: Double
    public var state: PlayerState = .idle
    public var animation: Animation = .smgIdle
    public let attackCooldown: Double = 0.25
    
    public init(position: Vector) {
        self.position = position
        self.velocity = Vector(x: 0, y: 0)
        self.direction = Vector(x: 1, y: 0)
        self.health = 100
    }
}

 public extension Player {
    var rect: Rect {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }
    
    var isDead: Bool
    {
        return health <= 0
    }
    
    var canFire: Bool
    {
        switch state
        {
        case .idle:
            return true
        case .firing:
            return animation.time >= attackCooldown
        }
    }

    func intersection(with map: Tilemap) -> Vector? {
        let minX = Int(rect.min.x), maxX = Int(rect.max.x)
        let minY = Int(rect.min.y), maxY = Int(rect.max.y)
        var largestIntersection: Vector?
        for y in minY ... maxY {
            for x in minX ... maxX where map[x, y].isWall {
                let wallRect = Rect(
                    min: Vector(x: Double(x), y: Double(y)),
                    max: Vector(x: Double(x + 1), y: Double(y + 1))
                )
                if let intersection = rect.intersection(with: wallRect),
                    intersection.length > largestIntersection?.length ?? 0 {
                    largestIntersection = intersection
                }
            }
        }
        return largestIntersection
    }
    
    func intersection(with monster: Monster) -> Vector?
    {
        return rect.intersection(with: monster.rect)
    }
    
    mutating func update(with input: Input, in world: inout World)
    {
        direction = direction.rotated(by: input.rotation)
        velocity = direction * input.speed * speed
        if input.isFiring, canFire
        {
            state = .firing
            animation = .smgFire
            let ray = Ray(origin: position, direction: direction)
            if let index = world.pickMonster(ray)
            {
                world.hurtMonster(at: index, damage: 10)
            }
        }
        switch state {
        case .idle:
            break
        case .firing:
            if animation.isCompleted {
                state = .idle
                animation = .smgIdle
            }
        }
    }
}

public extension Animation
{
    static let smgIdle = Animation(frames: [.smg], duration: 0)
    static let smgFire = Animation(frames: [.smgFire1, .smgFire2, .smgFire3, .smgFire4, .smgFire5, .smgFire6, .smgFire7, .smgFire8, .smgFire9, .smg], duration: 0.5)
}
