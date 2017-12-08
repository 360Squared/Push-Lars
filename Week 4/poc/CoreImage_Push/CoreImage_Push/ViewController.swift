//
//  ViewController.swift
//  CoreImage_Push
//
//  Created by Lars De Winter on 06/12/2017.
//  Copyright © 2017 Lars De Winter. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ciImage: CIImage!
    @IBOutlet weak var beforeProcessingImage: UIImageView!
    @IBOutlet weak var afterProcessingImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beforeProcessingImage.sizeToFit()
        afterProcessingImage.sizeToFit()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //        beforeProcessingImage.image = image
        //        dismiss(animated:true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            beforeProcessingImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func processImage(_ sender: UIButton) {
        ciImage = CIImage(image: beforeProcessingImage.image!)
        let filter = CIFilter(name: "CISepiaTone")
        let context = CIContext(options: nil)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(5.5, forKey: kCIInputIntensityKey)
        
        let sepiaImage = filter?.outputImage?.applyingFilter("CIBoxBlur", parameters: [kCIInputRadiusKey : 100.0])
        if let cgimg = context.createCGImage(sepiaImage!, from: (sepiaImage?.extent)!) {
            let processedImage = UIImage(cgImage: cgimg, scale: (beforeProcessingImage.image?.scale)!, orientation: (beforeProcessingImage.image?.imageOrientation)!)
            afterProcessingImage.image = processedImage
        }
    }
}

