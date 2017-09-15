import UIKit

class MainMenuCell: UITableViewCell, UICollectionViewDataSource {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    
    var items: [FeedItem] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feed_item_cell", for: indexPath) as! FeedItemCell
        
        let index = indexPath.row
        let item = items[index]
        cell.titleLabel?.text = item.title
        
        if let imageUrl = URL(string: "\(imageEndpoint)\(item.posterPath)") {
            let session = URLSession(configuration: .default)
            session.dataTask(with: imageUrl,
                             completionHandler: { [weak cell] (data, _, error) in
                                if let error = error {
                                    print(error)
                                }
                                
                                let image = UIImage(data: data!)!
                                cell?.imageView?.image = image
            }).resume()
        }
        
        
        return cell
    }
}
