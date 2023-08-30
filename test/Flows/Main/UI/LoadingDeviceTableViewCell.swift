//
//  LoadingDeviceTableViewCell.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit
import SnapKit

final class LoadingDeviceTableViewCell: UITableViewCell {
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let statusIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = .skeletonAccent
        return view
    }()
    
    private let statusLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = .skeletonAccent
        return view
    }()
    
    private let titleLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .skeletonAccent
        return view
    }()
    
    private let subtitleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .skeletonAccent
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .skeletonBackground
        selectionStyle = .none
    }
    
    private func setupViews() {
        contentView.addSubview(statusStackView)
        contentView.addSubview(titleLabelView)
        contentView.addSubview(subtitleView)
        
        statusStackView.addArrangedSubview(statusIndicatorView)
        statusStackView.addArrangedSubview(statusLabelView)
        
        statusStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(17)
            $0.leading.equalTo(contentView.snp.leading).inset(17)
        }
        
        statusIndicatorView.snp.makeConstraints {
            $0.size.equalTo(12)
        }
        
        statusLabelView.snp.makeConstraints {
            $0.width.equalTo(46)
            $0.height.equalTo(12)
        }
        
        titleLabelView.snp.makeConstraints {
            $0.height.equalTo(28)
            $0.width.equalTo(168)
            $0.top.equalTo(statusStackView.snp.bottom).offset(15)
            $0.leading.equalTo(contentView.snp.leading).inset(19)
        }
        
        subtitleView.snp.makeConstraints {
            $0.height.equalTo(27)
            $0.width.equalTo(130)
            $0.top.equalTo(titleLabelView.snp.bottom).offset(90).priority(.low)
            $0.leading.equalTo(contentView.snp.leading).inset(14)
            $0.bottom.equalTo(contentView.snp.bottom).inset(11)
        }
    }
}
