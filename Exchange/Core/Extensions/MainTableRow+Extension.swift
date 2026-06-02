import Foundation

extension Array where Element == MainTableRow {
    

    // Input Text
    func inputTextModel(identifier: InputTextCell.Identifier) -> InputTextCell.Model? {
        for row in self {
            if case .inputText(let model) = row, model.identifier == identifier {
                return model
            }
        }
        return nil
    }
    func inputTextValue(identifier: InputTextCell.Identifier) -> String {
        inputTextModel(identifier: identifier)?.value ?? ""
    }
    mutating func setInputTextValue(_ value: String, identifier: InputTextCell.Identifier) {
        for i in indices {
            guard case .inputText(var model) = self[i], model.identifier == identifier else { continue }
            model.value = value
            self[i] = .inputText(model)
            return
        }
    }
    
    // Input Text View
    func inputTextViewModel(identifier: InputTextViewCell.Identifier) -> InputTextViewCell.Model? {
        for row in self {
            if case .inputTextView(let model) = row, model.identifier == identifier {
                return model
            }
        }
        return nil
    }
    func inputTextViewValue(identifier: InputTextViewCell.Identifier) -> String {
        inputTextViewModel(identifier: identifier)?.value ?? ""
    }
    mutating func setInputTextViewValue(_ value: String, identifier: InputTextViewCell.Identifier) {
        for i in indices {
            guard case .inputTextView(var model) = self[i], model.identifier == identifier else { continue }
            model.value = value
            self[i] = .inputTextView(model)
            return
        }
    }

    // Input Token
    func inputTokenModel() -> InputTokenCell.Model? {
        for row in self {
            if case .inputToken(let model) = row {
                return model
            }
        }
        return nil
    }
    func inputTokenValue() -> String {
        inputTokenModel()?.token ?? ""
    }
    mutating func setInputTokenValue(_ value: String) {
        for i in indices {
            guard case .inputToken(var model) = self[i] else { continue }
            model.token = value
            self[i] = .inputToken(model)
            return
        }
    }
    
    // Input Slider
    func inputSliderModel(identifier: DefaultCell.Identifier) -> InputSliderCell.Model? {
        for row in self {
            if case .inputSlider(let model) = row, model.identifier == identifier {
                return model
            }
        }
        return nil
    }
    func inputSliderValue(identifier: DefaultCell.Identifier) -> Float {
        inputSliderModel(identifier: identifier)?.value ?? 0
    }
    mutating func setInputSliderValue(_ value: Float, identifier: DefaultCell.Identifier) {
        for i in indices {
            guard case .inputSlider(var model) = self[i], model.identifier == identifier else { continue }
            model.value = value
            self[i] = .inputSlider(model)
            return
        }
    }
    
    // Switch
    func switchModel(identifier: SwitchCell.Identifier) -> SwitchCell.Model? {
        for row in self {
            if case .switch(let model) = row, model.identifier == identifier {
                return model
            }
        }
        return nil
    }
    func switchValue(identifier: SwitchCell.Identifier) -> Bool {
        switchModel(identifier: identifier)?.isOn ?? false
    }
    mutating func setSwitchValue(_ value: Bool, identifier: SwitchCell.Identifier) -> Int? {
        for i in indices {
            guard case .switch(let model) = self[i], model.identifier == identifier else { continue }

            let updated = SwitchCell.Model(
                title: model.title,
                isOn: value,
                identifier: model.identifier
            )

            self[i] = .switch(updated)
            return i
        }
        return nil
    }
    
    
}
