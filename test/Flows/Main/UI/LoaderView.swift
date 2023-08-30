//
//  LoaderView.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit
import SnapKit

final class LoaderView: UIView {
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.backgroundColor = .clear
        view.color = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    private func setupUI() {
        layer.cornerRadius = 26
        backgroundColor = .white
        
        addSubview(activityIndicatorView)
        
        snp.makeConstraints {
            $0.size.equalTo(52)
        }
        
        activityIndicatorView.snp.makeConstraints {
            $0.centerX.equalTo(snp.centerX)
            $0.centerY.equalTo(snp.centerY)
        }
    }
}
