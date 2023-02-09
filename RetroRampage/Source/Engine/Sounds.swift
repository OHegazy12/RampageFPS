//
//  Sounds.swift
//  Engine
//
//  Created by Omar Hegazy on 2/5/23.

import Foundation
public enum SoundName: String, CaseIterable
{
    case smgFire
    case ricochet
    case monsterHit
    case monsterGroan
    case monsterDeath
    case monsterSwipe
    case doorSlide
    case wallSlide
    case wallThud
    case switchFlip
    case playerDeath
    case playerWalk
    case squelch
    
}

public struct Sound
{
    public let name: SoundName?
    public let channel: Int?
    public let volume: Double
    public let pan: Double
    public let delay: Double
}
