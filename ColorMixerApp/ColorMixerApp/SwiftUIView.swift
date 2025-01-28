//
//  SwiftUIView.swift
//  ColorMixerApp
//
//  Created by Nick Khachatryan on 27.01.2025.
//
// VIEW
import SwiftUI

struct SwiftUIView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Button {
            viewModel.tapOnButton(word: Word())
        } label: {
            Text("Tap on me")
        }
    }
}

#Preview {
    SwiftUIView()
}
