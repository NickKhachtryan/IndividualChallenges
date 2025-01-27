//
//  ColorStackView.swift
//  ColorMixerUIKit
//
//  Created by Nick Khachatryan on 27.01.2025.
//

import UIKit

class ColorStackView: UIView {
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "RED"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textAlignment = .center
//        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorRectangle: UIView = {
        let view = UIView()
        view.tintColor = .red
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.backgroundColor = .yellow
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorStackView)
        colorStackView.addArrangedSubview(colorLabel)
        colorStackView.addArrangedSubview(colorRectangle)
    }
}

extension ColorStackView {
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            colorStackView.topAnchor.constraint(equalTo: topAnchor),
            colorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorStackView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }
}
