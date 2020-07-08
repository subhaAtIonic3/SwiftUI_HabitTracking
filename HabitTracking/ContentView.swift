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
    @Published var habits = [Habit]()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
