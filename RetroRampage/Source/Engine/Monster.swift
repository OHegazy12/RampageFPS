//
//  Monster.swift
//  Engine
//
//  Created by Omar Hegazy on 6/21/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

public struct Monster: Actor
{
    public var position: Vector
    public let radius: Double = 0.4375
    public var state: MonsterState = .idle
    public let speed: Double = 0.5
    public var velocity: Vector = Vector(x: 0, y: 0)
    public var animation: Animation = .monsterIdle
    public let attackCooldown: Double = 0.4
    public private(set) var lastAttackTime: Double = 0
    
    public init(position: Vector)
    {
        self.position = position
    }
}

public enum MonsterState
{
    case idle
    case chasing
    case attacking
}

public extension Monster {
    mutating func update(in world: inout World) {
        switch state {
        case .idle:
            if canSeePlayer(in: world) {
                state = .chasing
                animation = .monsterWalk
            }
            velocity = Vector(x: 0, y: 0)
        case .chasing:
            guard canSeePlayer(in: world) else {
                state = .idle
                animation = .monsterIdle
                break
            }
            if canReachPlayer(in: world) {
                state = .attacking
                animation = .monsterAttack
                lastAttackTime = -attackCooldown
            }
            let direction = world.player.position - position
            velocity = direction * (speed / direction.length)
        case .attacking:
            guard canReachPlayer(in: world) else {
                state = .chasing
                animation = .monsterWalk
                break
            }
            if animation.time - lastAttackTime >= attackCooldown
            {
                lastAttackTime = animation.time
                world.hurtPlayer(10)
            }
        }
    }

    func canSeePlayer(in world: World) -> Bool {
        let direction = world.player.position - position
        let playerDistance = direction.length
        let ray = Ray(origin: position, direction: direction / playerDistance)
        let wallHit = world.map.hitTest(ray)
        let wallDistance = (wallHit - position).length
        return wallDistance > playerDistance
    }

    func canReachPlayer(in world: World) -> Bool {
        let reach = 0.75
        let playerDistance = (world.player.position - position).length
        return playerDistance - world.player.radius < reach
    }
}

public extension Animation
{
    static let monsterIdle = Animation(frames: [.monster], duration: 0)
    static let monsterWalk = Animation(frames: [.monsterWalk1, .monster, .monsterWalk2, .monster, .monsterWalk3, .monster, .monsterWalk4, .monster, .monsterWalk5, .monster, .monsterWalk6, .monster, .monsterWalk7, .monster, .monsterWalk8, .monster], duration: 0.5)
    static let monsterAttack = Animation(frames: [.monsterAttack1, .monsterAttack2, .monsterAttack3, .monsterAttack4, .monsterAttack5, .monsterAttack6, .monsterAttack7, .monsterAttack8, .monsterAttack9, .monsterAttack10], duration: 0.8)
}
