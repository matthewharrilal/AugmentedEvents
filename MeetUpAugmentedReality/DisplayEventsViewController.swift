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

class DisplayEventsViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
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
    

    func displayImage() -> SCNNode? {
        let imagePlane = SCNPlane(width: sceneView.bounds.width/6000, height: sceneView.bounds.height/6000)
        imagePlane.firstMaterial?.diffuse.contents = UIImage(named: "pin")
        imagePlane.firstMaterial?.lightingModel = .constant
        let node = SCNNode(geometry: imagePlane)
        print("HELLO WORLD")

        sceneView.scene.rootNode.addChildNode(node)
        return node
    }
    
    
    
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
