//
//  ACEmptyStateView.swift
//  ACMovies
//
//  Created by Chandan Kumar on 31/03/21.
//

import Foundation
import UIKit
import Masonry

final class ACEmptyStateView: UIView {
    // MARK: - Properties
    private let viewStateLabel: UILabel = {
        let label = UILabel()
        return label
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
        alpha = 0
        addSubview(viewStateLabel)
        viewStateLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.centerY.equalTo()(self.mas_centerY)
        }
        backgroundColor = .white
    }

    // MARK: - Public

    func showView(with text: String) {
        viewStateLabel.text = text

        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }

            self.alpha = 1
        }
    }

    func removeView() {
        viewStateLabel.text = ""

        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }

            self.alpha = 0
        }
    }
}

