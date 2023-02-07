//
//  SoundManager.swift
//  Rampage
//
//  Created by Omar Hegazy on 9/9/21.
//  Copyright © 2021 Nick Lockwood. All rights reserved.
//

// import AVFoundation

/**public class SoundManager: NSObject, AVAudioPlayerDelegate
{
    private var playing = Set<AVAudioPlayer>()
    
    public static let shared = SoundManager()
    
    private override init() {}
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playing.remove(player)
    }
}

public extension SoundManager
{
    func activate() throws
    {
        try AVAudioSession.sharedInstance().setActive(true)
    }
    
    func play(_ url: URL) throws
    {
        let player = try AVAudioPlayer(contentsOf: url)
        playing.insert(player)
        player.delegate = self
        player.play()
    }
}
*/
