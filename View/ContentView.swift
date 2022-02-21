//
//  ContentView.swift
//  ToDo
//
//  Created by Harsh Goutam on 07/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - property
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State var shownewTaskItem:Bool = false
    private var isbuttonDisabled: Bool{
        task.isEmpty
    }
    //MARK: - fetching data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - main
                VStack {
                    HStack(spacing: 10){
                        //title
                        Text("To Do")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                                    
                        Spacer()
                        //edit button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                            Capsule().stroke(Color.white, lineWidth: 2)
                        )
                        //apperance button
                        Button(action: {
                        // TOGGLE APPEARANCE
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                            }, label: {
                                Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(.title, design: .rounded))
                            })
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    //MARK: - header
                    Spacer(minLength: 80)
                    Button(action: {
                                shownewTaskItem = true
                                playSound(sound: "sound-ding", type: "mp3")
                                feedback.notificationOccurred(.success)
                              }, label: {
                                Image(systemName: "plus.circle")
                                  .font(.system(size: 30, weight: .semibold, design: .rounded))
                                Text("New Task")
                                  .font(.system(size: 24, weight: .bold, design: .rounded))
                              })
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .leading, endPoint: .trailing)
                                .clipShape(Capsule())
                                  )
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    
//                    VStack(spacing: 16){
//
////                        Button(action:{
////                                            addItem()
////                                        }, label: {
////                                            Spacer()
////                                            Text("Save")
////                                            Spacer()
////                                        })
////                            .disabled(isbuttonDisabled)
////                                            .padding()
////                                            .font(.headline)
////                                            .foregroundColor(.white)
////                                            .background(isbuttonDisabled ? Color.gray: Color.pink)
////                                            .cornerRadius(10)
//                    }.padding()
                    
                    List {
                        ForEach(items) { item in
                            ListItem(item: item)
//                            NavigationLink {
//                                VStack (alignment: .leading){
//                                    Text(item.task ?? "")
//                                        .font(.headline)
//                                        .fontWeight(.bold)
//                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                                        .font(.footnote)
//                                        .foregroundColor(.gray)
//                                }
//                            } label: {
//                                Text(item.timestamp!, formatter: itemFormatter)
//                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.3), radius: 12)
                    .padding(.vertical,0)
                    .frame(maxWidth: 640)
                }
                
                if shownewTaskItem{
                    BlankView(backgroundColor: .white, backgroundOpacity: 0)
                        .onTapGesture {
                            withAnimation(){
                                shownewTaskItem = false
                            }
                        }
                    NewTask(isShowing: $shownewTaskItem)
                }
            }.onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
                
            }
                
                    .navigationBarTitle("Daily To Do Tasks",displayMode: .large)
                    .navigationBarHidden(true)
                .background(
                    BackgroundImageView()
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all
                    ))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
}
    

    

    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
