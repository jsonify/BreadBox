//
//  AddRecipeView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct Scratchpad: View {
    @State var value1 = 33.3
    @State var value2 = 33.3
    @State var value3 = 33.3
    
    
    var body: some View {
        
        // add all bindings which you want to synchronize
        let allBindings = [$value1, $value2, $value3,]
        
        return VStack {
            
            Button(action: {
                // Manually setting the values does not change the values such
                // that they sum to 100. Use separate algorithm for this
                self.value1 = 33.333
                self.value2 = 33.333
                self.value3 = 33.333
            }) {
                Text("Reset")
            }
            
            
            Text("\(value1)")
            synchronizedSlider(from: allBindings, index: 0)
            
            Text("\(value2)")
            synchronizedSlider(from: allBindings, index: 1)
            
            Text("\(value3)")
            synchronizedSlider(from: allBindings, index: 2)
            
        }.padding()
    }
    
    
    func synchronizedSlider(from bindings: [Binding<Double>], index: Int) -> some View {
        return Slider(value: synchronizedBinding(from: bindings, index: index),
                      in: 0...100)
    }
    
    
    func synchronizedBinding(from bindings: [Binding<Double>], index: Int) -> Binding<Double> {
        
        return Binding(get: {
            return bindings[index].wrappedValue
        }, set: { newValue in
            
            let sum = bindings.indices.lazy.filter{ $0 != index }.map{ bindings[$0].wrappedValue }.reduce(0.0, +)
            // Use the 'sum' below if you initially provide values which sum to 100
            // and if you do not set the state in code (e.g. click the button)
            //let sum = 100.0 - bindings[index].wrappedValue
            
            let remaining = 100.0 - newValue
            
            if sum != 0.0 {
                for i in bindings.indices {
                    if i != index {
                        bindings[i].wrappedValue = bindings[i].wrappedValue * remaining / sum
                    }
                }
            } else {
                // handle 0 sum
                let newOtherValue = remaining / Double(bindings.count - 1)
                for i in bindings.indices {
                    if i != index {
                        bindings[i].wrappedValue = newOtherValue
                    }
                }
            }
            bindings[index].wrappedValue = newValue
        })
        
    }
    
}

struct Scratchpad_Previews: PreviewProvider {
    static var previews: some View {
        Scratchpad()
    }
}
