//
//  HomeViewController.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
   
    var categories = [CategoryModel]()
    var populars = [PopularModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hideBackground()
        if let layout = popularCollectionView?.collectionViewLayout as? CustomLayout {
          layout.delegate = self
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setCategories()
        setPopulars()
    }
    private func setCategories(){
        categories = [
            CategoryModel(title: "Uphills", image: UIImage(named: "Uphills" ), color: UIColor.init(hex: "#F9DEFF")),
            CategoryModel(title: "Work of art", image: UIImage(named: "Work of art" ), color:  UIColor.init(hex: "#FFEABA")),
            CategoryModel(title: "Sea & Beach", image: UIImage(named: "Sea & Beach" ), color:  UIColor.init(hex: "#AFEFFF")),
            CategoryModel(title: "Nature", image: UIImage(named: "Nature"), color:  UIColor.init(hex: "#DFFFC7")),
        ]
        categoriesCollectionView.reloadData()
    }
    private func setPopulars(){
        populars = [
            PopularModel(title: "Parision brigde", subTitle: "Paris, France", image: "https://images.unsplash.com/photo-1499856871958-5b9627545d1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2014&q=80", isFav: false),
            PopularModel(title: "The Lake", subTitle: "Venice, Italy", image: "https://images.unsplash.com/photo-1476802379768-84b0af3e39ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2100&q=80", isFav: false),
            PopularModel(title: "Enchanted rock", subTitle: "United States", image: "https://images.unsplash.com/photo-1532278951723-545f655c97f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1300&q=80", isFav: false),
            PopularModel(title: "Moraine Lake", subTitle: "AB, Canada", image: "https://images.unsplash.com/photo-1569429547919-5e8e4dff0010?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1825&q=80", isFav: false)
        ]
        popularCollectionView.reloadData()
    }
    
    @objc private func favAction(sender: UIButton){
        populars[sender.tag].isFav?.toggle()
        popularCollectionView.reloadData()
    }
  
}

extension HomeViewController:  CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 3 == 0 ? 200 : 150
    }
 
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {return categories.count }
        return populars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let single = categories[indexPath.row]
            cell.title.text = single.title
            cell.image.image = single.image
            cell.bgView.backgroundColor = single.color
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
        let single = populars[indexPath.row]
        cell.image.sd_setImage(with: URL(string:single.image ?? ""), completed: nil)
        cell.title.text = single.title
        cell.subTitle.text = single.subTitle
        cell.favBtn.tintColor = single.isFav ?? false ? UIColor(hex: "#E8BB53") : UIColor(hex: "#E3E3E3")
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(favAction), for: .touchUpInside)
        return cell
    }
}
extension HomeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == popularCollectionView else {return}
        let detailsVC = self.viewController(fromStoryBoard: "PlaceDetails", withIdentifier: "PlaceDetailsViewController") as! PlaceDetailsViewController
        detailsVC.placeDetails = populars[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
