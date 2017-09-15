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
            if cell.items.count == 0 {
                loadFeedTheatre(cell)
            }
            cell.onLoadNext = { [weak cell, weak self] in
                self?.loadFeedTheatre(cell)
            }
        case 1:
            if cell.items.count == 0 {
                loadFeedPopular(cell)
            }
            cell.onLoadNext = { [weak cell, weak self] in
                self?.loadFeedPopular(cell)
            }
        case 2:
            if cell.items.count == 0 {
                loadFeedRated(cell)
            }
            cell.onLoadNext = { [weak cell, weak self] in
                self?.loadFeedRated(cell)
            }
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
    
    private func loadFeedTheatre(_ cell: MainMenuCell?) {
        guard let count = cell?.items.count else {
            return
        }
        let page = 1 + count / defaultPageSize
        restApiService.fetchNewInTheatres(page: page, completion: { [weak self] (items, error) in
            if let error = error {
                showErrorAlert(error: error, parent: self)
            }
            guard let items = items else {
                return
            }
            cell?.items.append(contentsOf: items)
        })
    }
    
    private func loadFeedPopular(_ cell: MainMenuCell?) {
        guard let count = cell?.items.count else {
            return
        }
        let page = 1 + count / defaultPageSize
        restApiService.fetchPopular(page: page, completion: { [weak self] (items, error) in
            if let error = error {
                showErrorAlert(error: error, parent: self)
            }
            guard let items = items else {
                return
            }
            cell?.items.append(contentsOf: items)
        })
    }

    private func loadFeedRated(_ cell: MainMenuCell?) {
        guard let count = cell?.items.count else {
            return
        }
        let page = 1 + count / defaultPageSize
        restApiService.fetchHighestRatedThisYear(page: page, completion: { [weak self] (items, error) in
            if let error = error {
                showErrorAlert(error: error, parent: self)
            }
            guard let items = items else {
                return
            }
            cell?.items.append(contentsOf: items)
        })
    }

}

