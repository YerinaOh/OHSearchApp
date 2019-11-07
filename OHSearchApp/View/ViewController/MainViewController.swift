//
//  ViewController.swift
//  OHSearchApp
//
//  Created by Yesrina__dev Oh on 07/11/2019.
//  Copyright © 2019 Yesrina__dev Oh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchDimView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noimageView: UIImageView!
    
    var isAnimating : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        
        self.listTableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: "TableViewCell")
        
        self.noimageView.isHidden = true
        self.searchBarTopConstraint.constant = (UIScreen.main.bounds.height - 44 - (self.navigationController?.navigationBar.frame.size.height ?? 0.0)) / 2
        let searchField = self.searchBar.value(forKey: "searchField") as? UITextField
        self.searchBarLeftConstraint.constant = 20
        self.searchBarRightConstraint.constant = 20
        
        if let field = searchField {
            field.layer.cornerRadius = 15.0
            field.font = UIFont.systemFont(ofSize: 13)
            field.layer.masksToBounds = true
            field.returnKeyType = .search
        }
    }

    @IBAction func dimViewTouched(_ sender: Any) {
        self.searchBar.resignFirstResponder()
        self.searchDimView.isHidden = true
        self.searchBar.text = ""
    }
    

}
extension MainViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample.sample.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = sample.sample[indexPath.row]
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        searchBar.resignFirstResponder()
        searchDimView.isHidden = true
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isAnimating {
            return
        }
        let keyword = self.searchBar.text
        

    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.isAnimating = true
        self.searchBarTopConstraint.constant = 0
        self.searchBarLeftConstraint.constant = 0
        self.searchBarRightConstraint.constant = 0
        UIView.animate(withDuration: 0.7, animations: {
            
            self.view.layoutIfNeeded()
            self.searchDimView.alpha = 0.0
        }) { success in
            self.isAnimating = false
        }
        return true
    }
}

