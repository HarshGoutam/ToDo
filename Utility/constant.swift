//
//  constant.swift
//  ToDo
//
//  Created by Harsh Goutam on 07/02/22.
//

import SwiftUI

 let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


//MARKS: - UI
var backgroundGradient: LinearGradient {
  return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}


//MARK: - UX
let feedback = UINotificationFeedbackGenerator()
