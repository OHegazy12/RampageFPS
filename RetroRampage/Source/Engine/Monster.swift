//
//  Monster.swift
//  Engine
//
//  Created by Omar Hegazy on 6/21/21.

public enum MonsterState {
    case idle
    case chasing
    case scratching
    case hurt
    case dead
}

public struct Monster: Actor {
    public let speed: Double = 0.5
    public let radius: Double = 0.4375
    public var position: Vector
    public var velocity: Vector = Vector(x: 0, y: 0)
    public var health: Double = 50
    public var state: MonsterState = .idle
    public var animation: Animation = .monsterIdle
    public let attackCooldown: Double = 0.4
    public private(set) var lastAttackTime: Double = 0

    public init(position: Vector) {
        self.position = position
    }
}

public extension Monster {
    var isDead: Bool {
        return health <= 0
    }

    mutating func update(in world: inout World) {
        switch state {
        case .idle:
            if canSeePlayer(in: world) {
                state = .chasing
                animation = .monsterWalk
            }
        case .chasing:
            guard canSeePlayer(in: world) else {
                state = .idle
                animation = .monsterIdle
                velocity = Vector(x: 0, y: 0)
                break
            }
            if canReachPlayer(in: world) {
                state = .scratching
                animation = .monsterAttack
                lastAttackTime = -attackCooldown
                velocity = Vector(x: 0, y: 0)
                break
            }
            let direction = world.player.position - position
            velocity = direction * (speed / direction.length)
        case .scratching:
            guard canReachPlayer(in: world) else {
                state = .chasing
                animation = .monsterWalk
                break
            }
            if animation.time - lastAttackTime >= attackCooldown {
                lastAttackTime = animation.time
                world.hurtPlayer(10)
            }
        case .hurt:
            if animation.isCompleted {
                state = .idle
                animation = .monsterIdle
            }
        case .dead:
            if animation.isCompleted {
                animation = .monsterDead
            }
        }
    }

    func canSeePlayer(in world: World) -> Bool {
        let direction = world.player.position - position
        let playerDistance = direction.length
        let ray = Ray(origin: position, direction: direction / playerDistance)
        let wallHit = world.hitTest(ray)
        let wallDistance = (wallHit - position).length
        return wallDistance > playerDistance
    }

    func canReachPlayer(in world: World) -> Bool {
        let reach = 0.75
        let playerDistance = (world.player.position - position).length
        return playerDistance - world.player.radius < reach
    }

    func billboard(for ray: Ray) -> Billboard {
        let plane = ray.direction.orthogonal
        return Billboard(
            start: position - plane / 2,
            direction: plane,
            length: 1,
            texture: animation.texture
        )
    }

    func hitTest(_ ray: Ray) -> Vector? {
        guard isDead == false, let hit = billboard(for: ray).hitTest(ray) else {
            return nil
        }
        guard (hit - position).length < radius else {
            return nil
        }
        return hit
    }
}

public extension Animation
{
    static let monsterIdle = Animation(frames: [.monster], duration: 0)
    static let monsterWalk = Animation(frames: [.monsterWalk1, .monster, .monsterWalk2, .monster, .monsterWalk3, .monster, .monsterWalk4, .monster, .monsterWalk5, .monster, .monsterWalk6, .monster, .monsterWalk7, .monster, .monsterWalk8, .monster], duration: 0.5)
    static let monsterAttack = Animation(frames: [.monsterAttack1, .monsterAttack2, .monsterAttack3, .monsterAttack4, .monsterAttack5, .monsterAttack6, .monsterAttack7, .monsterAttack8, .monsterAttack9, .monsterAttack10], duration: 0.8)
    static let monsterHurt = Animation(frames: [.monsterHurt1, .monsterHurt2, .monsterHurt3], duration: 0.2)
    static let monsterDeath = Animation(frames: [.monsterHurt1, .monsterHurt2, .monsterHurt3, .monsterDeath1, .monsterDeath2, .monsterDeath3, .monsterDeath4, .monsterDeath5, .monsterDeath6, .monsterDeath7, .monsterDeath8, .monsterDeath9], duration: 0)
    static let monsterDead = Animation(frames: [.monsterDead], duration: 0)
}
