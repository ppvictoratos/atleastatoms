//
//  ContentView.swift
//  A2NiNG4K
//
//  Created by Pete Victoratos on 8/18/21.
//

import SwiftUI
import CoreData

//TODO: TOE MODE

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct ContentViewOLD: View {
    var timeHasPassed = false
    @State private var dropdown = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    //song title that fades into metadata
                    Spacer()
                    Text(timeHasPassed ? "song title" : "song metadata")
                    
                    //should be the frame width minus some
                    Spacer(minLength: 120)
                    
                    HStack {
                        
                        Button(action: {
                            print("autosave. make a new song")
                        }) {
                            Image(systemName: "plus")
                        }
                        
                        Button(action: {
                            self.dropdown.toggle()
                        }) {
                            Image(systemName: "book")
                        }
                    }
                    Spacer()
                }.padding(.top, 75)
                
                TrackSlider(times: [1.0, 25.0, 25.0, 50.0])
                    .padding()
                
                BasicSoundControls(volume: 0.5)
            }
            //transparent backed group box consisting of 4 tracks with custom knobs and with some type of color varient
            //has + underneath. on tap { add tracks }
            // • • +
            
            //an animating metronome, when tapped it will make sounds. **always plays a "chiller" veresion of the sound before a recording commences**
            
            //an h stack with a bar in between the amount of bars the tracks have followed by the BPM it is at
            
            //an h stack that has the record/play/pause button along with skipping buttons in each direction by BARS
            TrackShelf()
                .offset(x: -90, y: dropdown ? -200 : -565.0)
                .animation(.easeInOut(duration: 1.0))
        }
        
        //we do need an add track button too
        
        //im not sure what things i am allowed to init outside of the view for it to work properly ????
    }
    
}

struct ContentViewOLD_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewOLD()
    }
}
