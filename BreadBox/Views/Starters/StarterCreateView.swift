//
//  StarterCreateView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/30/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct StarterCreateView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var textBindingManager = TextBindingManager(limit: 5)
    
    @State private var starterName = ""
    @State private var flourAmount = 33.33
    @State private var waterAmount = 33.33
    @State private var seedAmount = 33.33
    @State private var instructions = ""
    
    var body: some View {
        //        let allBindings = [$flourAmount, $waterAmount, $seedAmount]
        
        VStack {
            HStack {
                Text("Create".uppercased())
                    .font(AvFont.header)
                    .tracking(3)
                    .bold()
                
                Spacer()
                
                HStack {
                    Button(action: {
                        Haptic().simpleSuccess()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel".uppercased())
                            .font(AvFont.subtitle)
                            .tracking(1)
                            .frame(width: 60, height: 25)
                            .background(Color("Crumb"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    
                    Button(action: {
                        Haptic().simpleSuccess()
                        self.populateCoreData()
                        //                            self.resetFields()
                    }) {
                        Text("Save".uppercased())
                            .tracking(1)
                            .font(AvFont.subtitle)
                            .frame(width: 60, height: 25)
                            .background(self.starterName.isEmpty ? Color("buttonGray") : Color("Crust"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        
                    }
                }
            }
            .padding(.horizontal, 30)
            
            VStack {
                HStack {
                    Text("Name your starter:".uppercased())
                        .font(AvFont.title)
                        .bold()
                        .tracking(0.5)
                        .disableAutocorrection(true)
                    
                    Spacer()
                }
                
                HStack {
                    TextField("", text: $starterName)
                        .onReceive(starterName.publisher.collect()) {
                            self.starterName = String($0.prefix(12))
                    }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1))))
                        .foregroundColor(Color("textField"))
                        .frame(width: 255, height: 39)
                    
                    Spacer()
                    
                }
                
            }
            .padding(.leading, 30)
            
            Spacer()
        }
        .padding(.top, 60)
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
    
    fileprivate func populateCoreData() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        
        let starter = Starter(context: self.moc)
        starter.name = self.starterName
        starter.createdDateString = dateString
        
        do {
            try self.moc.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print(error)
        }
    }
}

struct StarterCreateView_Previews: PreviewProvider {
    static var previews: some View {
        StarterCreateView()
    }
}
