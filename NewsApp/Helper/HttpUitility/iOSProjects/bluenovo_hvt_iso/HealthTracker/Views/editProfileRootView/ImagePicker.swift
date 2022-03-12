//
//  ImagePicker.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 01/08/21.
//

@objc protocol ImagePickerDelegate:class {
    func didFinishSelectImage(with image :UIImage?)
}

import Foundation
import UIKit

class ImagePicker: NSObject {
    
    weak var delegate : ImagePickerDelegate?
     var controller : InterfaceExtendedController?
    var pickerController : UIImagePickerController? = UIImagePickerController()
    
    
    let TAG = "ImagePicker"
    
    public init(presentationControler : InterfaceExtendedController,delegate : ImagePickerDelegate){
        super.init()
        
        self.delegate = delegate
        self.controller = presentationControler
        
        self.pickerController?.delegate = self
        self.pickerController?.allowsEditing = true

    }
    
    private func action(for type : UIImagePickerController.SourceType, title : String)-> UIAlertAction?{
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            Log.echo(key: TAG, text: "The selected source type \(type) not available")
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController?.sourceType = type
            guard let controller = pickerController  else{
                Log.echo(key: TAG, text: "No controoler found")
                return
            }
            self.controller?.present(controller, animated: true, completion: nil)
        }
    }
    
    
    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.controller?.present(alertController, animated: true)
    }
    
    func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
       controller.dismiss(animated: true, completion: nil)
       self.delegate?.didFinishSelectImage(with: image)
   }
    
}

extension ImagePicker : UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            Log.echo(key: TAG, text: "")
            self.pickerController(picker, didSelect: nil)
            return
        }
        self.pickerController(picker, didSelect: editedImage)
    }
}

extension ImagePicker : UINavigationControllerDelegate {
    
}
