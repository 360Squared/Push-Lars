//
//  ViewController.swift
//  CoreML_Push
//
//  Created by Lars De Winter on 07/12/2017.
//  Copyright © 2017 Lars De Winter. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    var request: VNCoreMLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = try? VNCoreMLModel(for: MobileNet().model)
        
        request = VNCoreMLRequest(model: model!, completionHandler: { [weak self] request, error in
            self?.processClassifications(for: request, error: error)
        })
        request.imageCropAndScaleOption = .centerCrop
    }

    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            textLabel.text = ""
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        let classifications = request.results as! [VNClassificationObservation]
        let topClassifications = classifications.prefix(2)
        let descriptions = topClassifications.map { classification in
            // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
            DispatchQueue.main.async { [weak self] in
                self?.textLabel.text?.append(String(format: "  (%.2f) %@\n", classification.confidence, classification.identifier))
            }
            print(String(format: "  (%.2f) %@", classification.confidence, classification.identifier))
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //        beforeProcessingImage.image = image
        //        dismiss(animated:true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = pickedImage
            DispatchQueue.global(qos: .userInitiated).async {
                let orientation = CGImagePropertyOrientation(rawValue: UInt32(pickedImage.imageOrientation.rawValue))
                let handler = VNImageRequestHandler(ciImage: CIImage(image: pickedImage)!, orientation: orientation!)
                do {
                    try handler.perform([self.request])
                } catch {
                    /*
                     This handler catches general image processing errors. The `classificationRequest`'s
                     completion handler `processClassifications(_:error:)` catches errors specific
                     to processing that request.
                     */
                    print("Failed to perform classification.\n\(error.localizedDescription)")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
