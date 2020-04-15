
import UIKit

class FlagsViewController: UIViewController, StoryboardInitialViewController {
        
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet var sfwSwitch: UISwitch!
    @IBOutlet var nsfwSwitch: UISwitch!
    @IBOutlet var nsflSwitch: UISwitch!
    
    var currentFlags: [Flags] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortingSegmentedControl.selectedSegmentIndex = AppSettings.sorting == Sorting.top.rawValue ? 0 : 1
        sfwSwitch.isOn = AppSettings.sfwActive || !AppSettings.isLoggedIn
        nsfwSwitch.isOn = AppSettings.nsfwActive && AppSettings.isLoggedIn
        nsflSwitch.isOn = AppSettings.nsflActive && AppSettings.isLoggedIn
        sfwSwitch.isEnabled = AppSettings.isLoggedIn
        nsfwSwitch.isEnabled = AppSettings.isLoggedIn
        nsflSwitch.isEnabled = AppSettings.isLoggedIn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = CGSize(width: 200, height: stackView.bounds.height + 40)
    }
    
    @IBAction func sortingSegmentedControlChanged(_ sender: UISegmentedControl) {
        AppSettings.sorting = sender.selectedSegmentIndex == 0 ? Sorting.top.rawValue : Sorting.neu.rawValue
    }
    
    @IBAction func sfwSwitchChanged(_ sender: UISwitch) {
        AppSettings.sfwActive = sender.isOn
    }
    
    @IBAction func nsfwSwitchChanged(_ sender: UISwitch) {
        AppSettings.nsfwActive = sender.isOn
    }
    
    @IBAction func nsflSwitchChanged(_ sender: UISwitch) {
        AppSettings.nsflActive = sender.isOn
    }
}
