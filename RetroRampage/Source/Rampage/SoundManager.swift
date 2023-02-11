//
//  SoundManager.swift
//  Rampage
//
//  Created by Omar Hegazy on 2/7/23.


import AVFoundation

public class SoundManager: NSObject, AVAudioPlayerDelegate
{
    private var playing = Set<AVAudioPlayer>()
    public static let shared = SoundManager()
    private override init() {}
    private var channels = [Int: (url: URL, player: AVAudioPlayer)]()
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        playing.remove(player)
    }
    
}

public extension SoundManager
{
    func activate() throws
    {
        try AVAudioSession.sharedInstance().setActive(true)
    }
    
    func preload(_ url: URL, channel: Int? = nil) throws -> AVAudioPlayer
    {
        if let channel = channel, let (oldURL, oldSound) = channels[channel]
        {
            if oldURL == url
            {
                return oldSound
            }
            oldSound.stop()
        }
        return try AVAudioPlayer(contentsOf: url)
    }
    
    func play(_ url: URL, channel: Int?, volume: Double, pan: Double) throws
    {
        let player = try preload(url, channel: channel)
        
        if let channel = channel
        {
            channels[channel] = (url, player)
            player.numberOfLoops = -1
        }
        
        playing.insert(player)
        player.delegate = self
        player.volume = Float(volume)
        player.pan = Float(pan)
        player.play()
    }
    
    func clearChannel(_ channel: Int)
    {
        channels[channel]?.player.stop()
        channels[channel] = nil
    }
    
    func clearAll()
    {
        channels.keys.forEach(clearChannel)
    }
}
