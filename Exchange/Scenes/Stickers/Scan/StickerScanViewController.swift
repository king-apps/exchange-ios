//
//  StickerScanViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import VisionKit


protocol StickerScanDisplayLogic: AnyObject {
    func onLoad(viewModel: StickerScan.Load.ViewModel)
    func onRecognizeText(viewModel: StickerScan.RecognizeText.ViewModel)
}


class StickerScanViewController: MainBaseViewController, StickerScanDisplayLogic {
  
    
    // Var's
    var interactor: StickerScanBusinessLogic?
    var router: (NSObjectProtocol & StickerScanRoutingLogic & StickerScanDataPassing)?
    
    @IBOutlet var scannerContainerView: UIView!
    @IBOutlet var viewHud: UIView!
    @IBOutlet var viewHudStickerFrame: UIView!
    @IBOutlet var viewLoading: UIActivityIndicatorView!
    
    private var scannerViewController: DataScannerViewController?
    private var hudOverlayLayer: CAShapeLayer?
    private var hasDisplayedScannerUnavailableAlert = false
    private var lastRecognizedCode: String?
    private var isPresentingResult = false
    private var isScannerScanning = false

  
    // Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
  
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        load()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHudOverlay()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
        
        guard isPresentingResult == false else {
            didDismissResult()
            return
        }
        
        startTextMonitoring()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard isPresentingResult == false else { return }
        
        stopTextMonitoring()
    }
    
    
    // Setup inputs
    func setupInputs() {
        hideLoading()
        
        viewHud.backgroundColor = .clear
        viewHud.isUserInteractionEnabled = false
        
        //
        viewHudStickerFrame.layer.borderWidth = 2
        viewHudStickerFrame.layer.cornerRadius = AppTheme.Radius.lg
        viewHudStickerFrame.layer.borderColor = UIColor.white.cgColor
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = StickerScan.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: StickerScan.Load.ViewModel) {
        
    }
    func onRecognizeText(viewModel: StickerScan.RecognizeText.ViewModel) {
        let code = viewModel.code.rawValue
        guard lastRecognizedCode != code else { return }
        
        lastRecognizedCode = code
        
        if let sticker = viewModel.sticker {
            print("Sticker scan found:", code, "id:", sticker.getId())
            routeToResult()
        } else {
            print("Sticker scan code without match:", code)
        }
    }

    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    
    private func routeToResult() {
        guard isPresentingResult == false else { return }
        
        isPresentingResult = true
        hideLoading()
        performSegue(withIdentifier: "Result", sender: nil)
    }
    
    
    // Handler scanner
    private func startTextMonitoring() {
        guard DataScannerViewController.isSupported && DataScannerViewController.isAvailable else {
            hideLoading()
            displayScannerUnavailableAlert()
            return
        }
        
        if let scanner = scannerViewController {
            startScanning(scanner)
            return
        }
        
        showLoading()

        let scanner = DataScannerViewController(
            recognizedDataTypes: [.text()],
            qualityLevel: .balanced,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: false,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: false,
            isHighlightingEnabled: false
        )
        
        scanner.delegate = self
        embedScanner(scanner)
        startScanning(scanner)
    }
    private func startScanning(_ scanner: DataScannerViewController) {
        guard isScannerScanning == false else {
            hideLoading()
            return
        }
        
        showLoading()
        
        do {
            try scanner.startScanning()
            isScannerScanning = true
            hideLoading()
        } catch {
            stopTextMonitoring()
            displayScannerUnavailableAlert()
        }
    }
    private func pauseTextMonitoring() {
        hideLoading()
        scannerViewController?.stopScanning()
        isScannerScanning = false
    }
    private func stopTextMonitoring() {
        pauseTextMonitoring()
        
        scannerViewController?.willMove(toParent: nil)
        scannerViewController?.view.removeFromSuperview()
        scannerViewController?.removeFromParent()
        scannerViewController = nil
    }
    private func embedScanner(_ scanner: DataScannerViewController) {
        addChild(scanner)
        scannerContainerView.addSubview(scanner.view)
        scanner.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scanner.view.topAnchor.constraint(equalTo: scannerContainerView.topAnchor),
            scanner.view.leadingAnchor.constraint(equalTo: scannerContainerView.leadingAnchor),
            scanner.view.trailingAnchor.constraint(equalTo: scannerContainerView.trailingAnchor),
            scanner.view.bottomAnchor.constraint(equalTo: scannerContainerView.bottomAnchor)
        ])
        
        scanner.didMove(toParent: self)
        scannerViewController = scanner
    }
    private func showLoading() {
        viewLoading.isHidden = false
        viewLoading.startAnimating()
    }
    private func hideLoading() {
        viewLoading.stopAnimating()
        viewLoading.isHidden = true
        viewHudStickerFrame.backgroundColor = .clear
    }
    private func setupHudOverlay() {
        hudOverlayLayer?.removeFromSuperlayer()
        
        let path = UIBezierPath(rect: viewHud.bounds)
        let frame = viewHudStickerFrame.convert(viewHudStickerFrame.bounds, to: viewHud)
        let framePath = UIBezierPath(
            roundedRect: frame,
            cornerRadius: viewHudStickerFrame.layer.cornerRadius
        )
        
        path.append(framePath)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillRule = .evenOdd
        layer.fillColor = UIColor.black.withAlphaComponent(0.55).cgColor
        
        viewHud.layer.insertSublayer(layer, at: 0)
        hudOverlayLayer = layer
    }
    func displayScannerUnavailableAlert() {
        guard hasDisplayedScannerUnavailableAlert == false else { return }
        
        hasDisplayedScannerUnavailableAlert = true
        displayAlert(nil, message: "App.Camera.Unavailable".localized)
    }
    func didRecognizeStickerTexts(_ texts: [String]) {
        guard isPresentingResult == false else { return }
        guard texts.isEmpty == false else { return }
        
        let request = StickerScan.RecognizeText.Request(texts: texts)
        interactor?.recognizeText(request: request)
    }
    func didDismissResult() {
        guard isPresentingResult else { return }
        
        isPresentingResult = false
        lastRecognizedCode = nil
        pauseTextMonitoring()
        startTextMonitoring()
    }
    
}
