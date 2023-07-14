//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 14.07.2023.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    @IBAction private func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
