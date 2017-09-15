import Foundation

let restApiService = RestApiService()

class RestApiService {
    
    fileprivate init() {
    }
    
    
    func fetch(_ endpoint: String, _ completion: @escaping ([FeedItem]?, NSError?) -> Void ) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: endpoint) else {
            completion(.none, NSError.message("Error: cannot create URL", code: 0))
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            if let error = error {
                completion(.none, error as NSError)
                return
            }
            
            guard let responseData = data else {
                completion(.none, NSError.message("Error: did not receive data", code: 0))
                return
            }
            
            do {
                guard let movies = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    completion(.none, NSError.message("Error trying to convert data to JSON", code: 0))
                    return
                }
                
                guard let results = movies["results"] as? [[String: Any]] else {
                    completion(.none, NSError.message("Could not get results from JSON", code: 0))
                    return
                }
                let items = results.flatMap{ FeedItem.fromJson( $0 ) }
                completion(items, .none)
            } catch  {
                completion(.none, NSError.message("Error trying to convert data to JSON", code: 0))
            }
        }
        task.resume()
    }
    
    var ratedPageInProgress:Int?
    var theatresPageInProgress:Int?
    var popularPageInProgress:Int?
    
    func fetchHighestRatedThisYear(page: Int, completion: @escaping ([FeedItem]?, NSError?) -> Void ) {
        if let p = ratedPageInProgress, p == page {
            completion(.none, .none)
            return
        }
        guard let endpoint = TMDB(build: {
            $0.baseURL = apiEndpoint
            $0.sortBy = "vote_average.desc"
            $0.voteCountGte = 500
            $0.page = page
            $0.year = 2017
            $0.apiKey = apiKey
        }).path() else {
            completion(.none, .none)
            return
        }
        ratedPageInProgress = page
        fetch(endpoint, completion)
        ratedPageInProgress = .none
    }
    
    func fetchPopular(page: Int, completion: @escaping ([FeedItem]?, NSError?) -> Void ) {
        if let p = ratedPageInProgress, p == page {
            completion(.none, .none)
            return
        }
        guard let endpoint = TMDB(build: {
            $0.baseURL = apiEndpoint
            $0.sortBy = TMDBSortBy.PopularityDesc.rawValue
            $0.page = page
            $0.year = 2017
            $0.apiKey = apiKey
        }).path() else {
            completion(.none, .none)
            return
        }
        popularPageInProgress = page
        fetch(endpoint, completion)
        popularPageInProgress = .none
    }
    
  
    func fetchNewInTheatres(page: Int, completion: @escaping ([FeedItem]?, NSError?) -> Void ) {
        if let p = theatresPageInProgress, p == page {
            completion(.none, .none)
            return
        }
        guard let endpoint = TMDB(build: {
            $0.baseURL = apiEndpoint
            $0.sortBy = TMDBSortBy.PopularityDesc.rawValue
            $0.page = page
            $0.primaryReleaseDateGte = monthAgo()
            $0.primaryReleaseDateLte = today()
            $0.year = 2017
            $0.apiKey = apiKey
        }).path() else {
            completion(.none, .none)
            return
        }
        theatresPageInProgress = page
        fetch(endpoint, completion)
        theatresPageInProgress = .none
    }
}
