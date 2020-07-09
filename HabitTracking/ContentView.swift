//
//  ContentView.swift
//  HabitTracking
//
//  Created by Subhrajyoti Chakraborty on 08/07/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habits = Habits()
    @State private var toggleAddView = false
    
    func deleteItem(at offset: IndexSet) {
        habits.habits.remove(atOffsets: offset)
        habits.save()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habits) { habit in
                    NavigationLink(destination: DetailView(habits: self.habits, itemId: habit.id)) {
                        HStack {
                            Text("\(habit.title)")
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .padding(.top)
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.toggleAddView.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $toggleAddView) {
                    AddHabitView(habits: self.habits)
            }
        }
    }
}

class Habits: ObservableObject {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Habits.plist")
    
    @Published var habits: [Habit]
    
    init() {
        self.habits = []
        self.getSavedData()
    }
    
    func save() {
        let encoder = PropertyListEncoder()
        do {
           let data = try encoder.encode(habits)
            try data.write(to: dataFilePath!)
        } catch {
            print("Unable to update data \(error)")
        }
    }
    
    func getSavedData() {
        guard let data = try? Data(contentsOf: dataFilePath!) else {
            return
        }
        let decoder = PropertyListDecoder()
        do {
            habits = try decoder.decode([Habit].self, from: data)
        } catch {
            print("Unable to decode \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
