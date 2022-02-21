//
//  HideKeyboard.swift
//  ToDo
//
//  Created by Harsh Goutam on 07/02/22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
