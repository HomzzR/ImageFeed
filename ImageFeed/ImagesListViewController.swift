//
//  ViewController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 02.07.2023.
//

import UIKit

final class ImagesListViewController: UIViewController {
    // MARK: - Private properties & IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Light content
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

    // MARK: - Private functions


    // MARK: - Extensions
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
