//
//  TabbarViewController.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import UIKit

class TabbarViewController: UITabBarController {

    private var indicatorView: UIView!
    private let indicatorHeight: CGFloat = 3
    private let indicatorWidth: CGFloat = 17
    private let indicatorYOffset: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.indicatorAnimate()
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        self.indicatorView = UIView()
        indicatorView.backgroundColor = .systemBlue
        self.tabBar.addSubview(indicatorView)
    }
    
    func indicatorAnimate() {
        let tabWidth = tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1)
        let xPosition = CGFloat(self.selectedIndex) * tabWidth + (tabWidth - indicatorWidth) / 2
        let yPosition = indicatorYOffset
        UIView.animate(withDuration: 0.2) {
            self.indicatorView.frame = CGRect(x: xPosition, y: yPosition, width: self.indicatorWidth, height: self.indicatorHeight)
        }
    }

}
