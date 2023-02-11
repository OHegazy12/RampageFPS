//
//  Pickup.swift
//  Engine
//
//  Created by Omar Hegazy on 2/10/23.


import Foundation

public enum PickupType
{
    case medkit
    case shotgun
}

public struct Pickup: Actor
{
    public var radius: Double = 0.4
    
    public var position: Vector
    
    public var type: PickupType
    
    public init(type: PickupType, position: Vector)
    {
        self.type = type
        self.position = position
    }
}

public extension Pickup
{
    var isDead: Bool
    {
        return false
    }
    
    var texture: Texture
    {
        switch type
        {
            case .medkit:
                return .medkit
            case .shotgun:
                return .shotgunPickup
        }
    }
    
    func billboard(for ray: Ray) -> Billboard
    {
        let plane = ray.direction.orthogonal
        return Billboard(start: position - plane / 2, direction: plane, length: 1, texture: texture)
    }
}
