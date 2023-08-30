//
//  DeviceTableViewCell.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit
import SnapKit

final class DeviceTableViewCell: UITableViewCell {
    
    var image: UIImage? {
        get { contentImageView.image }
        set { contentImageView.image = newValue }
    }
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.topGradient.cgColor, UIColor.bottomGradient.cgColor]
        layer.locations = [0.0 , 1.0]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        return layer
    }()
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.contentMode = .scaleAspectFit
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let statusIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 3
        return label
    }()
    
    private let subtitleUnderView: UIView = {
        let view = UIView()
        view.backgroundColor = .under
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        statusLabel.text = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        dateLabel.text = nil
        gradientLayer.frame = .zero
    }
    
    func configure(with viewModel: DeviceViewModel) {
        statusIndicatorView.backgroundColor = viewModel.isOn ? .active : .inactive
        statusLabel.text = viewModel.status
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.date
    }
    
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.addSublayer(gradientLayer)
    }
    
    private func setupViews() {
        contentView.addSubview(statusStackView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleUnderView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(contentImageView)
        
        statusStackView.addArrangedSubview(statusIndicatorView)
        statusStackView.addArrangedSubview(statusLabel)
        
        subtitleUnderView.addSubview(subtitleLabel)
        
        statusStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(17)
            $0.leading.equalTo(contentView.snp.leading).inset(17)
        }
        
        statusIndicatorView.snp.makeConstraints {
            $0.size.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(statusStackView.snp.bottom).offset(14)
            $0.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.5)
            $0.leading.equalTo(contentView.snp.leading).inset(17)
        }
        
        subtitleUnderView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(62)
            $0.leading.equalTo(contentView.snp.leading).inset(15)
            $0.height.equalTo(27)
            $0.width.equalTo(130)
            $0.bottom.equalTo(contentView.snp.bottom).inset(11)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(subtitleUnderView.snp.centerY)
            $0.centerX.equalTo(subtitleUnderView.snp.centerX)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(17)
            $0.bottom.equalTo(contentView.snp.bottom).inset(18).priority(.low)
        }
        
        contentImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(16)
            $0.trailing.equalTo(contentView.snp.trailing).inset(17)
            $0.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.45)
        }
    }
}
