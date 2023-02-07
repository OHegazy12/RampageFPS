//
//  Animation.swift
//  Engine
//
//  Created by Omar Hegazy on 6/24/21.

public struct Animation {
    public let frames: [Texture]
    public let duration: Double
    public var time: Double = 0

    public init(frames: [Texture], duration: Double) {
        self.frames = frames
        self.duration = duration
    }
}

public extension Animation {
    var isCompleted: Bool {
        return time >= duration
    }

    var texture: Texture {
        guard duration > 0 else {
            return frames[0]
        }
        let t = time.truncatingRemainder(dividingBy: duration) / duration
        return frames[Int(Double(frames.count) * t)]
    }
}
