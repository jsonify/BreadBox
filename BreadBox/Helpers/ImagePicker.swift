//
//  ImagePicker.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/19/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

}
