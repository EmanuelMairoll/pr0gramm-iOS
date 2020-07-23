
import UIKit
import ScrollingContentViewController

class UserInfoViewController: ScrollingContentViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    var viewModel: UserInfoViewModel!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var userClassDotView: UserClassDotView!
    @IBOutlet private var userClassLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.09411764706, alpha: 1)
        title = viewModel.name
        tabBarItem = UITabBarItem(title: "Profil",
                                  image: UIImage(systemName: "person.circle"),
                                  selectedImage: UIImage(systemName: "person.circle.fill"))
        
        let badgesCollectionViewController = BadgesCollectionViewController.fromStoryboard()
        badgesCollectionViewController.viewModel = viewModel
        addChild(badgesCollectionViewController)
        stackView.insertArrangedSubview(badgesCollectionViewController.view, at: 1)
        badgesCollectionViewController.didMove(toParent: self)
        
        let _ = viewModel.userInfo.observeNext { [unowned self] userInfo in
            guard let userInfo = userInfo else { return }
            self.scoreLabel.text = "Benis: \(userInfo.user.score)"
            self.userClassDotView.backgroundColor = Colors.color(for: userInfo.user.mark)
            self.userClassLabel.text = Strings.userClass(for: userInfo.user.mark)
        }
    }
    
    @IBAction func showCollectionsButtonTapped(_ sender: Any) {
        guard let navigationController = navigationController else { return }
        coordinator?.showCollections(viewModel: viewModel,
                                     navigationController: navigationController)
    }
    
    @IBAction func showUserUploadsButtonTapped(_ sender: Any) {
        guard let navigationController = navigationController else { return }
        coordinator?.showUserPosts(for: .user(name: viewModel.name),
                                   navigationController: navigationController)
    }
}
