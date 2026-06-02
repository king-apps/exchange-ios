//
//  MyProductInputImageInteractor.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 2/24/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol MyProductInputImageBusinessLogic {
    func load(request: MyProductInputImage.Load.Request)
    func save(request: MyProductInputImage.Save.Request)
}


protocol MyProductInputImageDataStore {
    var product: Product? { get set }
}


class MyProductInputImageInteractor: MyProductInputImageBusinessLogic, MyProductInputImageDataStore {
    
    
    // Var's
    var presenter: MyProductInputImagePresentationLogic?
    var worker = MyProductInputImageWorker()

    var product: Product?
    
    
    // Handler load
    func load(request: MyProductInputImage.Load.Request) {
        
        worker.load {
            let response = MyProductInputImage.Load.Response(
                product: self.product
            )
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: MyProductInputImage.Save.Request) {
        
        worker.save(product: self.product, images: request.images) { error in
            let response = MyProductInputImage.Save.Response(error: error)
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
