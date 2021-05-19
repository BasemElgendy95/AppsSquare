import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpSearchBarInNavigation(placeholder: String, delegate : UISearchBarDelegate){
        let searchBar = UISearchBar()
        searchBar.delegate = delegate
        searchBar.sizeToFit()
        searchBar.placeholder = placeholder
        if let fontStyle = UIFont(name: "neoSansArabic", size: 15) {
                   let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
                   textFieldInsideUISearchBar?.font = fontStyle
                   let placeholderLabel       = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
                   placeholderLabel?.font     = fontStyle
               }
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    func viewController(fromStoryBoard storyBoard: String , withIdentifier identifier: String) -> UIViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoard, bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        return newViewController
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
