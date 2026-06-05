//
//  StickerScanWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class StickerScanWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler scan
    func recognize(texts: [String]) -> StickerScan.Code? {
        let text = texts
            .joined(separator: " ")
            .folding(options: [.diacriticInsensitive, .widthInsensitive], locale: .current)
            .uppercased()
        
        let pattern = #"(?<![A-Z0-9])([A-Z]{3})\s*[-#]?\s*([0-9OIL]{1,3})(?![A-Z0-9])"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return nil
        }
        
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        guard let match = regex.firstMatch(in: text, range: range),
              let categoryCodeRange = Range(match.range(at: 1), in: text),
              let numberRange = Range(match.range(at: 2), in: text) else {
            return nil
        }
        
        let categoryCode = String(text[categoryCodeRange])
        guard let number = normalizeNumber(String(text[numberRange])) else {
            return nil
        }
        
        return StickerScan.Code(categoryCode: categoryCode, number: number)
    }
    
    func findSticker(code: StickerScan.Code) -> Sticker? {
        do {
            let stickerDatabase = try StickerDatabase()
            return try stickerDatabase.get(
                title: code.categoryCode,
                description: "\(code.number)"
            )
        } catch {
            return nil
        }
    }
    
    private func normalizeNumber(_ value: String) -> Int? {
        let normalized = value
            .replacingOccurrences(of: "O", with: "0")
            .replacingOccurrences(of: "I", with: "1")
            .replacingOccurrences(of: "L", with: "1")
        
        return Int(normalized)
    }
    
    
}
