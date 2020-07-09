//
//  DetailView.swift
//  HabitTracking
//
//  Created by Subhrajyoti Chakraborty on 08/07/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var habits: Habits
    @State private var count = 0
    @State private var habit = Habit(title: "Test", description: "test descp.", completionCount: 0)
    let itemId: UUID
    
    func getHabit(id: UUID) -> Habit {
        let habit = self.habits.habits.filter({ (item) -> Bool in
            return item.id == self.itemId
        })[0]
        
        return habit
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(habit.description)")
                
                Stepper("Completion Count: \(count)", onIncrement: {
                    self.habit.completionCount += 1
                    self.count += 1
                    self.habits.save()
                }, onDecrement: {
                    self.habit.completionCount -= 1
                    self.count -= 1
                    self.habits.save()
                })
            }
            .padding()
            .navigationBarTitle("\(habit.title)")
        }
        .onAppear {
            self.habit = self.getHabit(id: self.itemId)
            self.count = self.habit.completionCount
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habits: Habits(), itemId: UUID())
    }
}
