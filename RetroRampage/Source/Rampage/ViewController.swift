//
//  ViewController.swift
//  Rampage
//
//  Created by Nick Lockwood on 17/05/2019.
//  Programmed by Omar Hegazy on June 6th, 2021.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import UIKit
import Engine

class ViewController: UIViewController {
    private let imageView = UIImageView()
    private var world = World(map: loadMap())
    private var lastFrameTime = CACurrentMediaTime()
    
    @objc func update(_ displayLink: CADisplayLink)
    {
        let timeStep = displayLink.timestamp - lastFrameTime
        world.update(timeStep: timeStep)
        lastFrameTime = displayLink.timestamp
        
        let size = Int(min(imageView.bounds.width, imageView.bounds.height))
        var renderer = Renderer(width: size, height: size)
        renderer.draw(world)
        
        imageView.image = UIImage(bitmap: renderer.bitmap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
    }
    
    func setUpImageView()
    {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.magnificationFilter = .nearest
    }
}

private func loadMap() -> Tilemap
{
    let jsonURL = Bundle.main.url(forResource: "Map", withExtension: "json")!
    let jsonData = try! Data(contentsOf: jsonURL)
    return try! JSONDecoder().decode(Tilemap.self, from: jsonData)
}
