//
//  NewTask.swift
//  ToDo
//
//  Created by Harsh Goutam on 08/02/22.
//

import SwiftUI

struct NewTask: View {
    @Binding var isShowing: Bool
    @State private var task: String = ""
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    private var isButtonDisabled: Bool {
       task.isEmpty
     }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    var body: some View {
      VStack {
        Spacer()
        
        VStack(spacing: 16) {
          TextField("New Task", text: $task)
            .foregroundColor(.pink)
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .padding()
            .background(
              isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
            )
            .cornerRadius(10)
          
          Button(action: {
            addItem()
            playSound(sound: "sound-ding", type: "mp3")
            feedback.notificationOccurred(.success)
          }, label: {
            Spacer()
            Text("SAVE")
              .font(.system(size: 24, weight: .bold, design: .rounded))
            Spacer()
          })
          .disabled(isButtonDisabled)
          .onTapGesture {
            if isButtonDisabled {
              playSound(sound: "sound-tap", type: "mp3")
            }
          }
          .padding()
          .foregroundColor(.white)
          .background(isButtonDisabled ? Color.blue : Color.pink)
          .cornerRadius(10)
        } //: VSTACK
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(
          isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
        )
        .cornerRadius(16)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
        .frame(maxWidth: 640)
      } //: VSTACK
      .padding()
    }
  }


struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask(isShowing: .constant(true))
          
          .background(Color.gray.edgesIgnoringSafeArea(.all))
      }}
