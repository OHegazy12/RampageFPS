//
//  Weapon.swift
//  Engine
//
//  Created by Omar Hegazy on 2/10/23.

import Foundation

public enum Weapon
{
    case smg
    case shotgun
}


public extension Animation
{
    static let smgIdle = Animation(frames: [.smg], duration: 0)
    static let smgFire = Animation(frames: [.smgFire1, .smgFire2, .smgFire3, .smgFire4, .smgFire5, .smgFire6, .smgFire7, .smgFire8, .smgFire9, .smg], duration: 0.5)
    static let shotgunIdle = Animation(frames: [.shotgun], duration: 0)
    static let shotgunFire = Animation(frames: [.shotgunFire1, .shotgunFire2, .shotgunFire3, .shotgunFire4, .shotgun], duration: 0.5)
}

public extension Weapon
{
    struct Attributes
    {
        let idleAnimation: Animation
        let fireAnimation: Animation
        let fireSound: SoundName
        let damage: Double
        let cooldown: Double
        let projectiles: Int
        let spread: Double
        let defaultAmmo: Double
    }
    
    var attributes: Attributes
    {
        switch self
        {
            case .smg:
            return Attributes(idleAnimation: .smgIdle, fireAnimation: .smgFire, fireSound: .smgFire, damage: 30, cooldown: 0.3, projectiles: 3, spread: 0.2, defaultAmmo: .infinity)
            case .shotgun:
            return Attributes(idleAnimation: .shotgunIdle, fireAnimation: .shotgunFire, fireSound: .shotgunFire, damage: 50, cooldown: 0.5, projectiles: 5, spread: 0.4, defaultAmmo: 5)
        }
    }
}
