//
//  AddRecipeView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct Scratchpad: View {
     
     var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("dough3")
            .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Image(systemName: "plus")
                .foregroundColor(.white)
                .frame(width: 25, height: 25)
                .background(Color.blue)
            .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        }
    }
}

struct Scratchpad_Previews: PreviewProvider {
    static var previews: some View {
        Scratchpad()
    }
}
