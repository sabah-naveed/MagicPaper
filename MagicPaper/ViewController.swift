//
//  ViewController.swift
//  MagicPaper
//
//  Created by Sabah Naveed on 6/14/22.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "NewsImages", bundle: Bundle.main) {
        
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 4
            
            print("images successfully added")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        print("image detected")
        //look at anchor that got detected and return the node
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let videoNode = SKVideoNode(fileNamed: "harrypotter.mp4")
            videoNode.play()
            
            let videoScene = SKScene(size: CGSize(width: 1280, height: 720))
            videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
            videoNode.yScale = -1.5
            videoNode.xScale = 1.5
            videoScene.addChild(videoNode)
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = videoScene
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
        }
        
        return node
    }
}
