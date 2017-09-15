import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    
    private var theatreItems: [FeedItem] = []
    private var popularItems: [FeedItem] = []
    private var ratedItems: [FeedItem] = []
    
    private let titles = [
        "New In Theatres",
        "Popular",
        "Highest Rated This Year"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        fetchFeed()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feed_type_cell") as! MainMenuCell
        
        let index = indexPath.row
        cell.titleLabel?.text = titles[index]
        
        switch index {
        case 0:
            cell.items = theatreItems
        case 1:
            cell.items = popularItems
        case 2:
            cell.items = ratedItems
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return .none
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return .none
    }
    
    
    
    // MARK: - Feed fetching
    private func fetchFeed() {
        restApiService.fetchNewInTheatres { [weak self] (items, error) in
            if let error = error {
                showErrorAlert(error: error, parent: self)
            }
            
            guard let items = items else {
                return
            }
            
            self?.theatreItems = items
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView?.reloadRows(at: [indexPath], with: .fade)
        }
        
        restApiService.fetchPopular { [weak self] (items, error) in
            if let error = error {
                showErrorAlert(error: error, parent: self)
            }
            
            guard let items = items else {
                return
            }
            
            self?.popularItems = items
            let indexPath = IndexPath(row: 1, section: 0)
            self?.tableView?.reloadRows(at: [indexPath], with: .fade)
        }
        
        restApiService.fetchHighestRatedThisYear { [weak self] (items, error) in
            if let error = error {
                showErrorAlert(error: error, parent: self)
            }
            
            guard let items = items else {
                return
            }
            
            self?.ratedItems = items
            let indexPath = IndexPath(row: 2, section: 0)
            self?.tableView?.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
}

