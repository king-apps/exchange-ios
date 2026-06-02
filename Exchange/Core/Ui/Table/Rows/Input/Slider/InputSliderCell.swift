import UIKit


protocol InputSliderCellDelegate {
    func inputSliderCellValueChanged(identifier: DefaultCell.Identifier, value: Float)
}


class InputSliderCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelValue: UILabel!
    @IBOutlet var slider: UISlider!
    private var valueSufix: String = ""
    var delegate: InputSliderCellDelegate?
    var identifier: DefaultCell.Identifier = .none
    
    
    // Model
    struct Model {
        var title: String
        var value: Float
        var valueSufix: String
        var minimumValue: Float
        var maximumValue: Float
        var identifier: DefaultCell.Identifier
    }
    
    
    // Setup
    func setup(model: Model) {
        
        self.valueSufix = model.valueSufix
        labelTitle.text = model.title
        slider.minimumValue = model.minimumValue
        slider.maximumValue = model.maximumValue
        slider.value = model.value
        sliderValueChanged(slider)
        identifier = model.identifier
        
    }

    
    // Actions
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        labelValue.text = "\(Int(sender.value)) \(valueSufix)"
        delegate?.inputSliderCellValueChanged(identifier: self.identifier, value: sender.value)
    }
    
}
