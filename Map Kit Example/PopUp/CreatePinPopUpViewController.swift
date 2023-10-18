//
//  CreatePinPopUpViewController.swift
//  Map Kit Example
//
//  Created by fatih.sukran on 18.10.2023.
//

import UIKit

class CreatePinPopUpViewController: UIViewController {

    init() {
        super.init(nibName: "CreatePinPopUpViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
//        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
//        self.backView.alpha = 0
//        self.contentView.alpha = 0
//        self.contentView.layer.cornerRadius = 10
    }

}
