//
//  ACMovieDisplayCell.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import UIKit
import Masonry

let kDEFAULT_MINIMUM_OFFSET:CGFloat = 5.0

class ACMovieDisplayCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var movieCellVM:ACDisplayMovieVM? {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        guard let cellVM = movieCellVM else {
            return
        }
        
        titleLabel.text = cellVM.movieTitle
        
        if let image = cellVM.movieImage {
            self.movieImageView.image = image
        } else {
            cellVM.fetchMovieImage { image in
                self.movieImageView.image = image
            }
        }
        
        if cellVM.isFavourite == true {
            favouriteMovieButton.isHidden = true
        }
    }
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label : UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        return label
    }()
    
    lazy var favouriteMovieButton: UIButton = {
        let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
        let buttonImage = UIImage(systemName: "heart")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favouriteMovieButtonTouched), for: .touchUpInside)
        button.tintColor = .red
        return button
    }()
    
    lazy var movieContainerView: UIView = {
        var containerView = UIView(frame: CGRect.zero)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor(red:153/255, green:150/255, blue:150/255, alpha: 0.2).cgColor
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowRadius = 1
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    func addSubviews() {
        movieContainerView.addSubview(movieImageView)
        movieContainerView.addSubview(separatorView)
        movieContainerView.addSubview(titleLabel)
        movieContainerView.addSubview(favouriteMovieButton)
        
        contentView.addSubview(movieContainerView)
    }
    
    @objc func favouriteMovieButtonTouched() {
        guard let cellVM = movieCellVM else {
            return
        }
        
        cellVM.isFavourite = true
        let buttonImage = UIImage(systemName: "heart.fill")
        favouriteMovieButton.setImage(buttonImage, for: .normal)
        
        if cellVM.isFavourite == true {
            cellVM.saveMovieData()
        }
    }
    
    func setupConstraints() {
        movieImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(movieContainerView.mas_top)?.offset()(kDEFAULT_MINIMUM_OFFSET)
            make?.leading.equalTo()(movieContainerView)?.offset()(kDEFAULT_MINIMUM_OFFSET)
            make?.trailing.equalTo()(movieContainerView)?.offset()(-kDEFAULT_MINIMUM_OFFSET)
            make?.height.equalTo()(150)
        }
        
        separatorView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(movieImageView.mas_bottom)?.offset()(kDEFAULT_MINIMUM_OFFSET)
            make?.leading.equalTo()(movieContainerView)
            make?.trailing.equalTo()(movieContainerView)
            make?.height.equalTo()(2)
        }
        
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(separatorView.mas_bottom)?.offset()(kDEFAULT_MINIMUM_OFFSET)
            make?.leading.equalTo()(movieContainerView)?.offset()(kDEFAULT_MINIMUM_OFFSET)
            make?.trailing.equalTo()(movieContainerView)?.offset()(-kDEFAULT_MINIMUM_OFFSET)
            make?.bottom.equalTo()(movieContainerView.mas_bottom)?.offset()(-kDEFAULT_MINIMUM_OFFSET)
        }
        
        favouriteMovieButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(movieContainerView.mas_top)
            make?.trailing.equalTo()(movieContainerView)?.offset()
            make?.width.equalTo()(50)
            make?.height.equalTo()(50)
        }
        
        movieContainerView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.edges.equalTo()(contentView)
        }
        
    }
    
}
