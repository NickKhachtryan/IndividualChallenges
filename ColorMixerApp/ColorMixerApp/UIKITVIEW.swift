import SwiftUI
import UIKit

// Обертка для UIColorPickerViewController
struct ColorPickerView: UIViewControllerRepresentable {
    @Binding var selectedColor: Color
    @Binding var isPresented: Bool
    
    var supportsAlpha: Bool = true
    
    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIColorPickerViewController()
        picker.delegate = context.coordinator
        picker.selectedColor = UIColor(selectedColor)
        picker.supportsAlpha = supportsAlpha
        let navigationController = UINavigationController(rootViewController: picker)
        picker.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .close)
        picker.view.backgroundColor = .white
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let picker = (uiViewController as? UINavigationController)?.topViewController as? UIColorPickerViewController {
                    picker.selectedColor = UIColor(selectedColor)
                }    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: ColorPickerView
        
        init(parent: ColorPickerView) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            parent.selectedColor = Color(viewController.selectedColor)
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            parent.isPresented = false
        }
    }
}

// Основное представление
struct UIKitView: View {
    @State private var selectedColor: Color = .blue
    @State private var showColorPicker = true
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack(spacing: 20) {
                Button {
                    showColorPicker.toggle()
                } label: {
                    Rectangle()
                        .fill(selectedColor)
                        .frame(width: 200, height: 200)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if showColorPicker {
                ColorPickerView(selectedColor: $selectedColor, isPresented: $showColorPicker)
                    .frame(height: UIScreen.main.bounds.height * 0.7)
                    .padding(.bottom, 0)
            }
        }
//        .sheet(isPresented: $showColorPicker) {
////            NavigationStack {
//                ColorPickerView(
//                    selectedColor: $selectedColor,
//                    isPresented: $showColorPicker
//                )
//                .presentationDetents([.fraction(0.87)])
////                .toolbar {
////                    ToolbarItem(placement: .navigationBarTrailing) {
////                        Button {
////                            showColorPicker = false
////                        } label: {
////                            Image(systemName: "xmark.circle.fill")
////                                .resizable()
////                                .renderingMode(.template)
////                                .scaledToFit()
////                                .tint(.gray)
////                        }
////                    }
////                }
////            }
//        }
    }
}

#Preview {
    UIKitView()
}
