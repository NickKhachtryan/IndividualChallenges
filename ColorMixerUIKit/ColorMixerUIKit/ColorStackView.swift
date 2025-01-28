//
//  ColorStackView.swift
//  ColorMixerUIKit
//
//  Created by Nick Khachatryan on 27.01.2025.
//

import UIKit

class ColorStackView: UIView, UIColorPickerViewControllerDelegate {
    
    
    //MARK: - PUBLIC PROPERTIES
    weak var viewController: UIViewController?
    weak var delegate: ColorStackViewDelegate?
    
    
    //MARK: - PRIVATE PROPERTIES
    var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "RED"
        label.font = UIFont(name: "Avenir Next Bold", size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var colorRectangle: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSelectColor), for: .touchUpInside)
        return button
    }()
    
    private let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //MARK: - INITIALIZATORS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - METHODS
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorStackView)
        colorStackView.addArrangedSubview(colorLabel)
        colorStackView.addArrangedSubview(colorRectangle)
    }
    
    @objc func didTapSelectColor() {
        guard let viewController = viewController else {
            print("ViewController is not set")
            return
        }
        
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.selectedColor = colorRectangle.backgroundColor ?? .red
        colorPickerVC.modalPresentationStyle = .popover
        colorPickerVC.delegate = self
        viewController.present(colorPickerVC, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorRectangle.backgroundColor = color
        delegate?.colorDidChange()
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorRectangle.backgroundColor = color
        delegate?.colorDidChange()
    }
}


//MARK: - CONSTRAINTS
private extension ColorStackView {
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            colorRectangle.widthAnchor.constraint(equalTo: colorRectangle.heightAnchor),
            
            colorStackView.topAnchor.constraint(equalTo: topAnchor),
            colorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
}

