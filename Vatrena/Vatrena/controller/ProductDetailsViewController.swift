//
//  ProductDetailsViewController.swift
//  Vatrena
//
//  Created by Ahmed Ghalab on 8/2/17.
//  Copyright © 2017 Softcare, LLC. All rights reserved.
//

import UIKit

protocol ProductDetailsDelegate {
    func hideDetailsViewController()
}


class ProductDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var defaultpriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    
    var delegate : ProductDetailsDelegate?
    
    var item : VTItem!
    var store: VTStore!
    
    var initialFrame : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1, animations: { [unowned self] in
            self.view.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 160)
            self.productNameLabel.alpha = 1.0
            
        }) { [unowned self] _ in
            
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: { [unowned self] in
                self.defaultpriceLabel.alpha = 1.0
                self.descriptionLabel.alpha = 1.0
                self.optionsCollectionView.alpha = 1.0
            })
        }
    }
    
    func prepareViews(animated: Bool){
        productNameLabel.text = item.name
        defaultpriceLabel.text = "\(item.price) ريال"
        descriptionLabel.text = item.offering
        productImageView.image = UIImage(named: "product-placeholder")
        
        productImageView.loadingImageUsingCache(withURLString: item.imageURL ?? "")
    }
    
    
    func removeFromSuperView(animated : Bool){
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: { [unowned self] in
            self.view.frame = self.initialFrame
            self.optionsCollectionView.alpha = 0.0
        }) { [unowned self] _ in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }

    }
    
    @IBAction func hideDetailsAction(_ sender: UIButton) {
        delegate?.hideDetailsViewController()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return item.optionGroups?[section].options?.count ?? 0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"option-cell", for: indexPath) as! OptionCollectionViewCell
        cell.optionButton.tag = (indexPath.section * Constants.GROUP_OFFSET) + indexPath.row
        let option = item.optionGroups?[indexPath.section].options?[indexPath.row]
        cell.setOptionItem(option!)
        return cell
    }
    
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return item.optionGroups?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : OptionGroupCollectionHeaderReusableView!
        
        if kind == UICollectionElementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! OptionGroupCollectionHeaderReusableView
            reusableView.optionGroupTitleLabel.text = item.optionGroups?[indexPath.section].name
        }
        
        return reusableView
    }
    
    @objc(collectionView:layout:insetForSectionAtIndex:)  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        let combinedItemWidth:CGFloat = (CGFloat(numberOfItems) * flowLayout.itemSize.width) + ((CGFloat(numberOfItems) - 1) * flowLayout.minimumInteritemSpacing)
        let padding = (collectionView.frame.size.width - combinedItemWidth) / 2
        
        return UIEdgeInsetsMake(0, padding, 10, padding)
        
    }
    
    
    @IBAction func selectOptionAction(_ sender: UIButton) {
        let section = sender.tag / Constants.GROUP_OFFSET
        let row = sender.tag % Constants.GROUP_OFFSET
        
        let optionGroup = item.optionGroups![section]
        let option = optionGroup.options![row]
        
        if optionGroup.selectionType == .single {
            for optionItem in optionGroup.options! {
                optionItem.selected = false
            }
            option.selected = true
        }else{
            option.selected = !option.selected
        }
        
        UIView.setAnimationsEnabled(false)
        optionsCollectionView.reloadData()
        
        prepareViews(animated:true)
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(reEnableAnimationLayer), userInfo: nil, repeats: false)
    }
    
    func reEnableAnimationLayer() {
        UIView.setAnimationsEnabled(true)
    }
    

}
