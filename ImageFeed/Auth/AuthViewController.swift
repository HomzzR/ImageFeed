//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 29.07.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Private properties & IBOutlet
    
    private let showWebViewSegueIdentifier = "ShowWebView"
    
    // MARK: - Override
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(showWebViewSegueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Light content
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
    // MARK: - Extenstion

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        //TODO: process code
    }

    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}

