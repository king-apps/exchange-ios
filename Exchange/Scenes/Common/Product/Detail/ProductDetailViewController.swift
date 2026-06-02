//
//  ProductDetailViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher


protocol ProductDetailDisplayLogic: AnyObject {
    func onLoad(viewModel: ProductDetail.Load.ViewModel)
    func onFetch(viewModel: ProductDetail.Fetch.ViewModel)
}


class ProductDetailViewController: MainBaseViewController, ProductDetailDisplayLogic {
  
    
    // Var's
    var interactor: ProductDetailBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailRoutingLogic & ProductDetailDataPassing)?
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    var images = [UIImageView]()
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var labelName: UILabel!
    
    @IBOutlet var imageViewDistance: UIImageView!
    @IBOutlet var labelDistance: UILabel!
    
    @IBOutlet var imageViewIconCategory: UIImageView!
    @IBOutlet var labelCategory: UILabel!
    @IBOutlet var imageViewIconConservation: UIImageView!
    @IBOutlet var labelConservation: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var viewLine: UIView!

  
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
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // Setup inputs
    func setupInputs() {
        imageView1.layer.cornerRadius = AppTheme.Radius.lg
        imageView2.layer.cornerRadius = AppTheme.Radius.lg
        imageView3.layer.cornerRadius = AppTheme.Radius.lg
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = ProductDetail.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ProductDetail.Load.ViewModel) {
        images = [
            imageView1,
            imageView2,
            imageView3
        ]
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = ProductDetail.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: ProductDetail.Fetch.ViewModel) {
        
        // Images
        var index: Int = 0
        for image in viewModel.images {
            images[index].kf.setImage(with: URL(string: image))
            index += 1
        }
        if index < 3 {
            imageView3.removeFromSuperview()
        }
        if index < 2 {
            imageView2.removeFromSuperview()
        }
        
        // Page control
        pageControl.numberOfPages = viewModel.images.count
        if pageControl.numberOfPages == 1 {
            pageControl.removeFromSuperview()
        }
        
        // Name
        labelName.text = viewModel.name
        
        // Distance
        if viewModel.distance.isEmpty {
            imageViewDistance.removeFromSuperview()
            labelDistance.removeFromSuperview()
        }
        else {
            labelDistance.text = viewModel.distance
        }
        
        // Category
        if !viewModel.categoryImage.isEmpty {
            imageViewIconCategory.image = UIImage(named: viewModel.categoryImage)
            imageViewIconCategory.layer.masksToBounds = true
            imageViewIconCategory.layer.cornerRadius = imageViewIconCategory.bounds.width / 2
            imageViewIconCategory.contentMode = .scaleAspectFill
        }
        labelCategory.text = viewModel.category
        
        // Conservation
        if viewModel.conservation.isEmpty {
            imageViewIconConservation.removeFromSuperview()
            labelConservation.removeFromSuperview()
        }
        else {
            labelConservation.text = viewModel.conservation
        }
        
        // Description
        if viewModel.description.isEmpty {
            viewLine.removeFromSuperview()
            labelDescription.removeFromSuperview()
        }
        else {
            labelDescription.text = viewModel.description
        }
        
        
        DispatchQueue.main.async(execute: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    
    
}
