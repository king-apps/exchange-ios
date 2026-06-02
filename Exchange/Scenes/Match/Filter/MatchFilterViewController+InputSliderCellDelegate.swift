extension MatchFilterViewController: InputSliderCellDelegate {
    
    func inputSliderCellValueChanged(identifier: DefaultCell.Identifier, value: Float) {
        rows.setInputSliderValue(value, identifier: identifier)
        save()
    }
    
}
