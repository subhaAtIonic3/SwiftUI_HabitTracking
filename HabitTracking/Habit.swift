//
//  Habit.swift
//  HabitTracking
//
//  Created by Subhrajyoti Chakraborty on 08/07/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import Foundation


struct Habit: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var completionCount: Int
}
