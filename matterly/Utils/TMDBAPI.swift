//
//  TMDBAPI.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/15/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

protocol TMDBAPI {
    var baseURL: String? { get }
    var certificationCountry: String? { get }
    var voteCountGte: Int? { get }
    var page: Int? { get }
    var apiKey:String? { get }
    var year: Int? { get }
    var sortBy: String? { get }
    var includeVideo: Bool? { get }
    var includeAdult: Bool? { get }
    var language: String? { get }
}

enum TMDBMethods: String {
    case Discover = "discover/movie"
}

enum TMDBCountries: String {
    case US = "US"
}

enum TMDBSortBy: String {
    case PopularityAsc = "popularity.asc"
    case PopularityDesc = "popularity.desc"
    case ReleaseDateAsc = "release_date.asc"
    case ReleaseDateDesc = "release_date.desc"
}

enum TMDBLanguages: String {
    case EN_US = "en-US"
}

class TMDB: TMDBAPI {
    var baseURL: String?
    var method: String? = TMDBMethods.Discover.rawValue
    var certificationCountry: String? = TMDBCountries.US.rawValue
    var voteCountGte: Int?
    var page: Int?
    var apiKey: String?
    var year: Int?
    var sortBy: String?
    var primaryReleaseDateGte: String?
    var primaryReleaseDateLte: String?
    var includeVideo: Bool? = false
    var includeAdult: Bool? = false
    var language: String? = TMDBLanguages.EN_US.rawValue
    
    typealias buildTMDBClosure = (TMDB) -> Void
    
    init(build: buildTMDBClosure) {
        build(self)
    }
    
    func path() -> String? {
        guard var path = self.baseURL else {
            return .none
        }
        guard let method = self.method else {
            return .none
        }
        path += "/\(method)"
        
        var queryParams = "?"
        if let cc = self.certificationCountry {
            queryParams += "certification_country=\(cc)&"
        }
        if let vcgte = self.voteCountGte {
            queryParams += "vote_count.gte=\(vcgte)&"
        }
        if let pdgte = self.primaryReleaseDateGte {
            queryParams += "primary_release_date.gte=\(pdgte)&"
        }
        if let pdlte = self.primaryReleaseDateLte {
            queryParams += "primary_release_date.lte=\(pdlte)&"
        }
        if let page = self.page {
            queryParams += "page=\(page)&"
        }
        if let includeVideo = self.includeVideo {
            queryParams += "include_video=\(includeVideo)&"
        }
        if let sortBy = self.sortBy {
            queryParams += "sort_by=\(sortBy)&"
        }
        if let includeAdult = self.includeAdult {
            queryParams += "include_adult=\(includeAdult)&"
        }
        if let year = self.year {
            queryParams += "year=\(year)&"
        }
        if let apiKey = self.apiKey {
            queryParams += "api_key=\(apiKey)"
        }
        
        if queryParams.characters.count > 1 {
            path += queryParams
            if path.hasSuffix("&") {
                let suffixIndex = path.index(path.endIndex, offsetBy: -1)
                return path.substring(to: suffixIndex)
            }
        }
        
        return path
    }
}
