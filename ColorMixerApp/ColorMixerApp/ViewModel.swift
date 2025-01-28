//
//  ViewModel.swift
//  ColorMixerApp
//
//  Created by Nick Khachatryan on 27.01.2025.
//
// VIEWMODEL
import Foundation

class ViewModel: ObservableObject {
    func tapOnButton(word: Word) {
        print(word.word)
    }
}

