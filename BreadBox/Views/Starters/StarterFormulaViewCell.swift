//
//  StarterFormulaViewCell.swift
//  BreadBox
//
//  Created by Jason Rueckert on 6/1/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct StarterFormulaViewCell: View {
    var starter: Starter
    
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Text("\(self.starter.name)".uppercased())
                        .bold()
                        .kerning(1)
                        .scaledFont(name: "Avenir", size: 18)
                        .foregroundColor(Color("Crumb"))
                    
                    Spacer()
                }
                
            Text(self.starter.updatedDateString.isEmpty ? "Created: \(self.starter.createdDateString)".uppercased() : "Updated: \(self.starter.updatedDateString)".uppercased())
                    .kerning(2)
                    .foregroundColor(Color("Crumb"))
                    .scaledFont(name: "Avenir", size: 10)
                    
            }
            .padding(20)
            .frame(maxWidth:.infinity)
            .frame(maxHeight:70)
            .background(Color("Crust"))
            .cornerRadius(14)
        .padding()
    }
}

struct StarterFormulaViewCell_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let starter = Starter(context: moc)
        starter.name = "Lucy"
        starter.updatedDateString = "Jun 1, 2020"
        
        return StarterFormulaViewCell(starter: starter)
    }
}
