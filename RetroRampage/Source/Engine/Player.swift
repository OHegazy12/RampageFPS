//
//  Player.swift
//  Engine
//
//  Created by Omar Hegazy on 6/12/21.

public enum PlayerState {
    case idle
    case firing
}

public struct Player: Actor {
    public let speed: Double = 2
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
    var isDead: Bool {
        return health <= 0
    }

    var canFire: Bool {
        switch state {
        case .idle:
            return true
        case .firing:
            return animation.time >= attackCooldown
        }
    }

    mutating func update(with input: Input, in world: inout World) {
        direction = direction.rotated(by: input.rotation)
        velocity = direction * input.speed * speed
        if input.isFiring, canFire {
            state = .firing
            animation = .smgFire
            let ray = Ray(origin: position, direction: direction)
            if let index = world.pickMonster(ray) {
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
