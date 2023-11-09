//
//  HomeTableViewCell.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var hexColorView: UIView!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel : HomeCellViewModel?{
        didSet{
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        hexColorView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(){
        
        guard let viewModel = viewModel else {return}
        
        taskLabel.text = viewModel.taskName
        
        titleLabel.text = viewModel.titleName
        
        descriptionLabel.text = viewModel.descriptionName
        
        hexColorView.backgroundColor = UIColor(hexString: viewModel.hexColor)
        
    }
}
