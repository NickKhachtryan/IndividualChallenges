//
//  ViewController.swift
//  ColorMixerUIKit
//
//  Created by Nick Khachatryan on 27.01.2025.
//

import UIKit

class ViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Color Mixer"
        label.textColor = .black
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = .black
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let equalLabel: UILabel = {
        let label = UILabel()
        label.text = "="
        label.textColor = .black
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    private let firstcolorStackView = ColorStackView()
    private let secondColorStackView = ColorStackView()
    private let mixedColorStackView = ColorStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .gray
        view.addSubview(titleLabel)
        view.addSubview(firstcolorStackView)
        view.addSubview(secondColorStackView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(firstcolorStackView)
        stackView.addArrangedSubview(plusLabel)
        stackView.addArrangedSubview(secondColorStackView)
        stackView.addArrangedSubview(equalLabel)
        stackView.addArrangedSubview(mixedColorStackView)
    }

}

extension ViewController {
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            firstcolorStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            firstcolorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            firstcolorStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
//            firstcolorStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
//            
//            secondColorStackView.topAnchor.constraint(equalTo: firstcolorStackView.bottomAnchor, constant: 20),
//            secondColorStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
//            secondColorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            secondColorStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)

        ])
    }
}

