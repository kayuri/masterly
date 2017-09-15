import UIKit

class MainMenuCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        
        cell.imageView?.image = .none
        if let image = imageCacheService.getImage(name: item.posterPath) {
            cell.imageView?.image = image
        } else {
        
        imageService.fetchImage(item.posterPath, { [weak cell] (data, _, error) in
            if let error = error {
                print(error)
            }
            let image = UIImage(data: data!)!
            imageCacheService.cache(name: item.posterPath, image: image)
            cell?.imageView?.image = image
        })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 205.0)
    }
}
