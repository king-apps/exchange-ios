import VisionKit


extension StickerScanViewController: DataScannerViewControllerDelegate {
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        didRecognize(items: allItems)
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        didRecognize(items: allItems)
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        didRecognize(items: allItems)
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
        displayScannerUnavailableAlert()
    }
    
    private func didRecognize(items: [RecognizedItem]) {
        let texts = items.compactMap { item -> String? in
            guard case .text(let text) = item else { return nil }
            return text.transcript
        }
        
        didRecognizeStickerTexts(texts)
    }
    
}
