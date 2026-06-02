import Foundation


extension [Any] {
    
    
    func getInputTextCellModel(identifier: InputTextCell.Identifier) -> InputTextCell.Model? {
        if let model = self.first(where: {($0 as? InputTextCell.Model)?.identifier == identifier}) as? InputTextCell.Model {
            return model
        }
        return nil
    }
    func getInputTextCellValue(identifier: InputTextCell.Identifier) -> String {
        if let model = getInputTextCellModel(identifier: identifier) {
            return model.value
        }
        return ""
    }
    func getInputSliderCellModel(identifier: DefaultCell.Identifier) -> InputSliderCell.Model? {
        if let model = self.first(where: {($0 as? InputSliderCell.Model)?.identifier == identifier}) as? InputSliderCell.Model {
            return model
        }
        return nil
    }
    func getInputSliderCellValue(identifier: DefaultCell.Identifier) -> Float {
        if let model = getInputSliderCellModel(identifier: identifier) {
            return model.value
        }
        return 0
    }
    
}

