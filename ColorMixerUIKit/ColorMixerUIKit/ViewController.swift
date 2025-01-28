//
//  ViewController.swift
//  ColorMixerUIKit
//
//  Created by Nick Khachatryan on 27.01.2025.
//

import UIKit

class ViewController: UIViewController, ColorStackViewDelegate {
    
    
    //MARK: - PRIVATE PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Color Mixer"
        label.font = UIFont(name: "Avenir Next Bold", size: 26)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let equalLabel: UILabel = {
        let label = UILabel()
        label.text = "="
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let firstcolorStackView = ColorStackView()
    private let secondColorStackView = ColorStackView()
    private let mixedColorStackView = ColorStackView()
    
    
    //MARK: - VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        setUpDelegates()
    }
    
    
    //MARK: - METHODS
    private func getRGBFromColor(color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    private func mixColors(firstColor: UIColor, secondColor: UIColor) -> UIColor {
        let mixedColor: UIColor
        
        let firstRed = getRGBFromColor(color: firstColor).red
        let firstGreen = getRGBFromColor(color: firstColor).green
        let firstBlue = getRGBFromColor(color: firstColor).blue
        let firstAlpha = getRGBFromColor(color: firstColor).alpha
        
        let secondRed = getRGBFromColor(color: secondColor).red
        let secondGreen = getRGBFromColor(color: secondColor).green
        let secondBlue = getRGBFromColor(color: secondColor).blue
        let secondAlpha = getRGBFromColor(color: secondColor).alpha
        
        mixedColor = UIColor(red: (firstRed + secondRed) / 2,
                             green: (firstGreen + secondGreen) / 2,
                             blue: (firstBlue + secondBlue) / 2,
                             alpha: (firstAlpha + secondAlpha) / 2)
        
        return mixedColor
    }
    
    func colorDistance(from color1: UIColor, to color2: UIColor) -> CGFloat {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        // Получаем компоненты цветов
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        // Вычисляем евклидово расстояние
        let dr = r1 - r2
        let dg = g1 - g2
        let db = b1 - b2
        let da = a1 - a2
        
        return sqrt(dr * dr + dg * dg + db * db + da * da)
    }

    // Основная функция для определения ближайшего цвета
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
    
    func colorDidChange() {
        mixedColorStackView.colorRectangle.backgroundColor = mixColors(firstColor: firstcolorStackView.colorRectangle.backgroundColor!, secondColor: secondColorStackView.colorRectangle.backgroundColor!)
        firstcolorStackView.colorLabel.text = closestColorName(to: firstcolorStackView.colorRectangle.backgroundColor ?? .white)
        secondColorStackView.colorLabel.text = closestColorName(to: secondColorStackView.colorRectangle.backgroundColor ?? .white)
        mixedColorStackView.colorLabel.text = closestColorName(to: mixedColorStackView.colorRectangle.backgroundColor ?? .white)
    }
    
    private func setUpDelegates() {
        firstcolorStackView.viewController = self
        firstcolorStackView.delegate = self
        
        secondColorStackView.viewController = self
        secondColorStackView.delegate = self
    }
    
    private func setUpView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstcolorStackView)
        stackView.addArrangedSubview(plusLabel)
        stackView.addArrangedSubview(secondColorStackView)
        stackView.addArrangedSubview(equalLabel)
        stackView.addArrangedSubview(mixedColorStackView)
    }
    
}


//MARK: - CONSTRAINTS
private extension ViewController {
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

