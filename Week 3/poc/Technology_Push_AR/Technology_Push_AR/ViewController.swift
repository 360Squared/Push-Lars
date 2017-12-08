//
//  ViewController.swift
//  Technology_Push_AR
//
//  Created by Lars De Winter on 29/11/2017.
//  Copyright © 2017 Lars De Winter. All rights reserved.
//

import UIKit
import CoreLocation
import ARKit
import SceneKit
import MapKit

class ViewController: UIViewController /*, CLLocationManagerDelegate*/ {
    var sceneLocationView = SceneLocationView()
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        var coordinate = CLLocationCoordinate2D(latitude: 51.98669101, longitude: 5.95163246)
        var location = CLLocation(coordinate: coordinate, altitude: 9.9026313781738)
        var image = UIImage(named: "tile")!
        var annotationNode = LocationAnnotationNode(location: location, image: textToImage(drawText: "Vacature\nBeroep: Bakker\nSalaris: 50k\nAfstand: 5 min fietsen", inImage: image, atPoint: CGPoint(x: 20, y: 20)))
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        coordinate = CLLocationCoordinate2D(latitude: 51.98670101, longitude: 5.95163246)
        location = CLLocation(coordinate: coordinate, altitude: 9.5026313781738)
        image = UIImage(named: "tile")!
        annotationNode = LocationAnnotationNode(location: location, image: textToImage(drawText: "Vacature\nBeroep: Monteur\nSalaris: 25.010k\nAfstand: 10 min trien", inImage: image, atPoint: CGPoint(x: 20, y: 20)))
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 20)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touched")
    }
}
