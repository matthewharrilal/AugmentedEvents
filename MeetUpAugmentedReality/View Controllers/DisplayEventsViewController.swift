//
//  ViewController.swift
//  MeetUpAugmentedReality
//
//  Created by Matthew Harrilal on 3/13/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import KeychainSwift

class DisplayEventsViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var frontDefaultImageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        displayImage()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        
        getImageUrl()
        
        view.addSubview(pokemonButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
    func getImageUrl() {
        
        let pokemonNetworking = PokemonModelNetworkingLayer()
        
        pokemonNetworking.getPokemonImage { (data) in
            guard let json = try? JSONDecoder().decode(Pokemon.self, from: data) else {return}
            print("THis is the json \(json)")
            let keychain = KeychainSwift()
            keychain.set(json.frontDefault, forKey: "frontDefault")
        }
    }
    

    func displayImage() -> SCNNode? {
        let keychain = KeychainSwift()
        let data = try? Data(contentsOf: URL(string: keychain.get("frontDefault")! )!)
        let uiImage  = UIImage(data: data!)
    
        
        let imagePlane = SCNPlane(width: sceneView.bounds.width/6000, height: sceneView.bounds.height/6000)
        imagePlane.firstMaterial?.diffuse.contents = uiImage
        imagePlane.firstMaterial?.lightingModel = .constant
        let node = SCNNode(geometry: imagePlane)
        print("The node was added")
        sceneView.scene.rootNode.addChildNode(node)
        return node
    }
    
    var pokemonButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Poke", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        btn.center = CGPoint(x: UIScreen.main.bounds.width*0.85, y: UIScreen.main.bounds.height*0.90)
        btn.layer.cornerRadius = btn.bounds.height/2
        print("User wants pokemon generated")
        return btn
    }()
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
