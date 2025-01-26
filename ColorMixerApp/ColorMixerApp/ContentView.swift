//
//  ContentView.swift
//  ColorMixerApp
//
//  Created by Nick Khachatryan on 25.01.2025.
//

import SwiftUI
import Foundation
import UIKit


struct ContentView: View {
    
    
    //MARK: - CUSTOM PROPERTIES
    @State private var firstColor = Color.red
    @State private var secondColor = Color.blue
    @State private var mixedColor = Color.purple
    
    @State private var firstColorName = "Red"
    @State private var secondColorName = "Blue"
    @State private var mixedColorName = "Purple"
        
    
    //MARK: - UI
    var body: some View {
        VStack {

            Spacer()
            
            Text("Color mixer")
                .font(.largeTitle)
            
            Spacer()
            
            VStack {
                Text(NSLocalizedString(firstColorName, comment: ""))
                
                firstColor
                    .colorRectangleStyle()
                
                ColorPicker("", selection: $firstColor)
                    .labelsHidden()
                    .onChange(of: firstColor) {
                        updateColorsAndColorNames()
                    }
            }
            
            Spacer()
            
            Text("+")
                .font(.title)
            
            Spacer()
            
            VStack {
                Text(NSLocalizedString(secondColorName, comment: ""))
                
                secondColor
                    .colorRectangleStyle()
                
                ColorPicker("", selection: $secondColor)
                    .labelsHidden()
                    .onChange(of: secondColor) {
                        updateColorsAndColorNames()
                    }
            }
            
            Spacer()
            
            Text("=")
                .font(.title)
            
            Spacer()
            
            VStack {
                Text(NSLocalizedString(mixedColorName, comment: ""))
                
                mixedColor
                .colorRectangleStyle()
            }
            
            Spacer()
            
        }
        .onAppear {
            updateColorsAndColorNames()
        }
    }
    
    
    //MARK: - METHODS
    func getRGBFromColor(color: Color) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let uiColor = UIColor(color)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    func mixColor(firstColor: Color, secondColor: Color) -> Color {
        let firstRed: CGFloat = getRGBFromColor(color: firstColor).red
        let firstGreen: CGFloat = getRGBFromColor(color: firstColor).green
        let firstBlue: CGFloat = getRGBFromColor(color: firstColor).blue
        let firstAlpha: CGFloat = getRGBFromColor(color: firstColor).alpha
        
        let secondRed: CGFloat = getRGBFromColor(color: secondColor).red
        let secondGreen: CGFloat = getRGBFromColor(color: secondColor).green
        let secondBlue: CGFloat = getRGBFromColor(color: secondColor).blue
        let secondAlpha: CGFloat = getRGBFromColor(color: secondColor).alpha
        
        let mixedColor = Color(red: (firstRed + secondRed) / 2,
                               green: (firstGreen + secondGreen) / 2,
                               blue: (firstBlue + secondBlue) / 2,
                               opacity: (firstAlpha + secondAlpha) / 2)
        return mixedColor
    }
    
    func updateColorsAndColorNames() {
        mixedColor = mixColor(firstColor: firstColor, secondColor: secondColor)
        firstColorName = closestColorName(to: UIColor(firstColor)) ?? "Unknown"
        secondColorName = closestColorName(to: UIColor(secondColor)) ?? "Unknown"
        mixedColorName = closestColorName(to: UIColor(mixedColor)) ?? "Unknown"
    }
    
    func closestColorName(to color: UIColor) -> String? {
        let colorNames: [String: UIColor] = [
                "Red": .red,
                "Green": .green,
                "Blue": .blue,
                "Yellow": .yellow,
                "Orange": .orange,
                "Purple": .purple,
                "Brown": .brown,
                "Gray": .gray,
                "Black": .black,
                "White": .white
            ]
            
            var closestName: String?
            var smallestDistance: CGFloat = .greatestFiniteMagnitude
            
            for (name, namedColor) in colorNames {
                let distance = colorDistance(from: color, to: namedColor)
                if distance < smallestDistance {
                    smallestDistance = distance
                    closestName = name
                }
            }
            
            return closestName
        }
        
        func colorDistance(from color1: UIColor, to color2: UIColor) -> CGFloat {
            var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
            var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
            
            color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
            color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
            
            let redDiff = r1 - r2
            let greenDiff = g1 - g2
            let blueDiff = b1 - b2
            
            return sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff)
        }
}


//MARK: - MODIFIERS
struct ColorRectangle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.height * 0.15,
                   height: UIScreen.main.bounds.height * 0.15)
            .clipShape(.rect(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
            }
    }
}

extension View {
    func colorRectangleStyle() -> some View {
        modifier(ColorRectangle())
    }
}


//MARK: - PREVIEW
#Preview {
        ContentView()
}
