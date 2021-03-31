//
//  ACLoadingView.swift
//  ACMovies
//
//  Created by Chandan Kumar on 31/03/21.
//

import Foundation
import UIKit
import Masonry

final class ACLoadingView: UIView {
    // MARK: - Properties
    private let loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        return loadingIndicator
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setup() {
        addSubview(loadingIndicator)
        loadingIndicator.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.equalTo()(30)
            make?.height.equalTo()(30)
        }
        backgroundColor = .white
    }

    // MARK: - Public

    func startAnimatingIndicator() {
        self.alpha = 1
        self.loadingIndicator.startAnimating()
    }

    func stopAnimatingIndicator() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }

            self.alpha = 0
            self.loadingIndicator.stopAnimating()
        }
    }
}

