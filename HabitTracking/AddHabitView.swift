//
//  AddHabitView.swift
//  HabitTracking
//
//  Created by Subhrajyoti Chakraborty on 08/07/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    
    @State private var habitTitle = ""
    @State private var habitDescription = ""
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var toggleAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $habitTitle)
                TextField("Description", text: $habitDescription)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Add"){
                if self.habitTitle.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || self.habitDescription.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                    self.toggleAlert.toggle()
                    return
                }
                
                self.habits.habits.append(Habit(title: self.habitTitle, description: self.habitDescription, completionCount: 0))
                self.presentationMode.wrappedValue.dismiss()
            })
                .alert(isPresented: $toggleAlert) {
                    Alert(title: Text("Warning"), message: Text("Please add title and description"), dismissButton: .default(Text("OK")))
                    
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
