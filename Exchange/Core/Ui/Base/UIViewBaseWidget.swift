//
//  UIViewWidget.swift
//  Kimba
//
//  Created by Douglas Cicarello on 05/10/24.
//
import UIKit


class UIViewBaseWidget: UIView {
    
    
    // Var's
    var onTap: (() -> Void)?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = AppTheme.Radius.sm
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        onTap?()
    }
    
    
    // Define o fator de escala para o efeito de empurrar
    let scaleFactor: CGFloat = 0.96
    
    
    // Quando o toque começa
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // Anima a escala da view para simular o efeito de empurrar
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: self.scaleFactor, y: self.scaleFactor)
        })
    }
    
    // Quando o toque termina
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        // Volta a view ao tamanho original com animação
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
    // Quando o toque é cancelado (se o dedo deslizar para fora da view)
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        // Volta a view ao tamanho original se o toque for cancelado
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
}
