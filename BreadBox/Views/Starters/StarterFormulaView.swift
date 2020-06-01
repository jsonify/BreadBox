//
//  StarterFormulaView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/19/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct StarterFormulaView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Starter.entity(), sortDescriptors: []) var starters: FetchedResults<Starter>
    
    @State private var showingStarterCreateView = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Starters".uppercased())
                                .kerning(6)
                                .bold()
                                .scaledFont(name: "Avenir", size: 28)
                            
                            Spacer()
                            
                                Button(action: {
                                    Haptic().simpleSuccess()
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Close".uppercased())
                                        .font(AvFont.subtitle)
                                        .tracking(1)
                                        .frame(width: 60, height: 25)
                                        .background(Color("Crumb"))
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                }
                                
                            
                            
                        }
                        .padding(.horizontal, 30)
    //                    .padding(.top, 60)
                        
                        List {
                            ForEach(self.starters, id: \.self) { starter in
                                NavigationLink(destination:
                                    StarterDetailView(starter: starter)
                                ){
                                    Text("\(starter.name)")
                                }
                                
                            }
                            .onDelete(perform: deleteStarter)
                        }
                        .onAppear { UITableView.appearance().separatorStyle = .none }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Image("icon-plus")
                        .foregroundColor(Color("Crust"))
                        .onTapGesture {
                            self.showingStarterCreateView.toggle()
                            Haptic().simpleSuccess()
                    }
                    .sheet(isPresented: $showingStarterCreateView) {
                        StarterCreateView().environment(\.managedObjectContext, self.moc)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 40)
            }
            .padding(.top, 30)
            .statusBar(hidden: true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func deleteStarter(at offsets: IndexSet) {
        Haptic().simpleWarning()
        for offset in offsets {
            // find this book in our fetch request
            let starter = starters[offset]
            
            // delete it from the context
            moc.delete(starter)
        }
        
        // save the context
        try? moc.save()
    }
}

struct StarterFormulaView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return StarterFormulaView().environment(\.managedObjectContext, context)
    }
}
