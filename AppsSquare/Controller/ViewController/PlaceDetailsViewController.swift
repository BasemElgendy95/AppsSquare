//
//  PlaceDetailsViewController.swift
//  AppsSquare
//
//  Created by BasemElgendy on 20/05/2021.
//

import UIKit
import SDWebImage



class PlaceDetailsViewController: UIViewController {

    @IBOutlet weak var imageBGView: UIImageView!
    
    var placeDetails : PopularModel?
    let images = ["https://images.unsplash.com/photo-1499856871958-5b9627545d1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2014&q=80" ,"https://images.unsplash.com/photo-1476802379768-84b0af3e39ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2100&q=80","https://images.unsplash.com/photo-1532278951723-545f655c97f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1300&q=80","https://images.unsplash.com/photo-1569429547919-5e8e4dff0010?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1825&q=80","https://images.unsplash.com/photo-1621390324893-ea412aa9453c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3400&q=80"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageBGView.sd_setImage(with: URL(string:placeDetails?.image ?? ""), completed: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-squared_menu"), style: .plain, target: self, action: nil)
    }

    @IBAction func loginAction(_ sender: UIButton){
        let loginVC = self.viewController(fromStoryBoard: "Login", withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.authDelegate = self
        self.present(loginVC, animated: true, completion: nil)
    }
}
 
extension PlaceDetailsViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil, completion: nil)
        imageBGView.sd_setImage(with: URL(string:images[indexPath.row] ), completed: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                            }, completion: nil)
        default:
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            }, completion: nil)
        }
        return CGSize(width: 60 , height: 60 )
    }
}

extension PlaceDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceImageCollectionViewCell", for: indexPath) as! PlaceImageCollectionViewCell
        cell.image.sd_setImage(with: URL(string:images[indexPath.row] ), completed: nil)
        return cell
    }
    
}

extension PlaceDetailsViewController : AuthDelegate {
    
    func successLogin(user: UserModel)  {
        BGAlertPresenter.displayAlert(title: "Hi \(user.fullName ?? "" )", message: "Thank you for use our application", doneBtn: "done", forController: self)
    }
}
