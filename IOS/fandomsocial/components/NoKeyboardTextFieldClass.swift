//
//  NoKeyboardTextField.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import SwiftUI
import UIKit
import os

// Custom UITextField that prevents keyboard from appearing
class NoKeyboardTextFieldClass: UITextField {
    private let emptyInputView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let emptyAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var cursorVisible: Bool = true {
        didSet {
            // Invalidate the cursor display when visibility changes
            if oldValue != cursorVisible && isFirstResponder {
                // Force the caret to redraw by invalidating the layout
                setNeedsLayout()
                layoutIfNeeded()
                // Also invalidate the display to ensure caret updates
                setNeedsDisplay()
            }
        }
    }
    
    override var inputView: UIView? {
        get {
            // Always return empty view to prevent keyboard
            return emptyInputView
        }
        set {
            // Ignore any attempts to set inputView - always keep it empty
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            // Return empty accessory view
            return emptyAccessoryView
        }
        set {
            // Ignore any attempts to set inputAccessoryView
        }
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        // Return zero rect to hide cursor if cursorVisible is false, otherwise return default
        if !cursorVisible {
            return .zero
        }
        return super.caretRect(for: position)
    }
}

struct NoKeyboardTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool
    var textFontStyle: UIFont = .systemFont(ofSize: 14)
    var cursorVisible: Bool = true
    var placeholder: String
    var onTap: (() -> Void)?
    var textAlignment: NSTextAlignment = .left
    
    func makeUIView(context: Context) -> NoKeyboardTextFieldClass {
        let textField = NoKeyboardTextFieldClass()
        textField.text = text
        textField.textColor = .white
        textField.font = textFontStyle
        textField.textAlignment = textAlignment
        textField.cursorVisible = cursorVisible
        
        // Store reference in coordinator for programmatic dismissal
        context.coordinator.textField = textField
        
        // Set placeholder color
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        )
        
        // Handle tap to show custom keypad
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldTapped(_:)), for: .touchDown)
        
        // Set delegate to handle text changes
        textField.delegate = context.coordinator
        
        return textField
    }
    
    func updateUIView(_ uiView: NoKeyboardTextFieldClass, context: Context) {
        // Update text field reference in case it changed
        context.coordinator.textField = uiView
        
        if uiView.text != text {
            uiView.text = text
        }
        
        // Handle programmatic dismissal when isFocused changes to false
        // Only dismiss if text field is currently first responder to avoid RTIInputSystemClient warnings
        if !isFocused && uiView.isFirstResponder {
            context.coordinator.dismissTextField()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NoKeyboardTextField
        weak var textField: NoKeyboardTextFieldClass?
        
        init(_ parent: NoKeyboardTextField) {
            self.parent = parent
        }
        
        func dismissTextField() {
            // Safely dismiss text field using window.endEditing to avoid RTIInputSystemClient warnings
            DispatchQueue.main.async {
                if let textField = self.textField, let window = textField.window {
                    window.endEditing(true)
                }
            }
        }
        
        @objc func textFieldTapped(_ textField: UITextField) {
            // Let UIKit handle becoming first responder naturally through touchDown
            parent.onTap?()
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // Sync binding when text field becomes first responder naturally
            if !parent.isFocused {
                parent.isFocused = true
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            // Sync binding when text field resigns first responder naturally
            if parent.isFocused {
                parent.isFocused = false
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Allow programmatic text changes (from custom keypad and paste)
            let allowedCharecters = "0123456789"
            let allowedCharecterSet = CharacterSet(charactersIn: allowedCharecters)
            let typedCharecters = CharacterSet(charactersIn: string)
            if allowedCharecterSet.isSuperset(of: typedCharecters) {
                return true
            }
            return false
        }
    }
}



