import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
        
    private let titles = [
        "New In Theatres",
        "Popular",
        "Highest Rated This Year"
    ]
    
    
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
            setupCell(cell: cell, fetcher: loadFeedTheatre)
        case 1:
            setupCell(cell: cell, fetcher: loadFeedPopular)
        case 2:
            setupCell(cell: cell, fetcher: loadFeedRated)
        default:
            break
        }
        
        return cell
    }
    
    private func setupCell(cell: MainMenuCell, fetcher: @escaping (MainMenuCell?) -> Void ) {
        if cell.items.count == 0 {
            fetcher(cell)
        }
        
        cell.onLoadNext = { [weak cell] in
            fetcher(cell)
        }
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
            
            feedStorageService.theatreItems.append(contentsOf: items)
            cell?.items = feedStorageService.theatreItems
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
            
            feedStorageService.popularItems.append(contentsOf: items)
            cell?.items = feedStorageService.popularItems
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
            
            feedStorageService.ratedItems.append(contentsOf: items)
            cell?.items = feedStorageService.ratedItems
        })
    }

}

