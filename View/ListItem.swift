//
//  ListItem.swift
//  ToDo
//
//  Created by Harsh Goutam on 08/02/22.
//

import SwiftUI

struct ListItem: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item

    var body: some View {
        Toggle(isOn: $item.completion) {
            withAnimation{
                
                Text(item.task ?? "")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(item.completion ? Color.pink : Color.primary)
                                .padding(.vertical, 12)
            }
              
                
            } // toggle
            .toggleStyle(CheckBoxStyle())
            .onReceive(item.objectWillChange, perform: { _ in
              if self.viewContext.hasChanges {
                try? self.viewContext.save()
              }
            })
          }
    }

