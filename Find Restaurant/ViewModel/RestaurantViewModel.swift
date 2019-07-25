//
//  RestaurantViewModel.swift
//  Find Restaurant
//
//  Created by Ray Chow on 24/7/2019.
//  Copyright © 2019 RayChow. All rights reserved.
//

import Foundation
import RxSwift

class RestaurantViewModel{
    static let shared = RestaurantViewModel()
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let restaurants:PublishSubject<[Restaurant]> = PublishSubject()
    let filteredRestaurants:PublishSubject<[Restaurant]> = PublishSubject()
    
    var restaurantsArr:[Restaurant] = []
    
    /// NSPredicate expression keys.
    private enum ExpressionKeys: String {
        case title
        case district
        case address
        case reason
    }
    
    func reloadData(){
        generateRestaurantData()
    }
    
    private func generateRestaurantData(){
        restaurantsArr = [Restaurant(title: "Aascaacskacsacsmkackcascascacscascasacsaac", district: "FANLING", address: "sacaassaascca", ""),
                          Restaurant(title: "B", district: "SHATIN", address: "asc12212e", ""),
                          Restaurant(title: "C", district: "YEUN LONG", address: "wrbverv", "")]
        restaurants.onNext(restaurantsArr)
    }
    
    func findMatch(searchString: String){
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchString.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        let filteredResults = restaurantsArr.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        // Apply the filtered results to the search results table.
        filteredRestaurants.onNext(filteredResults)
    }
    
    private func findMatches(searchString: String) -> NSCompoundPredicate {
        /** Each searchString creates an OR predicate for: name, yearIntroduced, introPrice.
         Example if searchItems contains "Gladiolus 51.99 2001":
         name CONTAINS[c] "gladiolus"
         name CONTAINS[c] "gladiolus", yearIntroduced ==[c] 2001, introPrice ==[c] 51.99
         name CONTAINS[c] "ginger", yearIntroduced ==[c] 2007, introPrice ==[c] 49.98
         */
        var searchItemsPredicate = [NSPredicate]()
        
        /** Below we use NSExpression represent expressions in our predicates.
         NSPredicate is made up of smaller, atomic parts:
         two NSExpressions (a left-hand value and a right-hand value).
         */
        
        // Name field matching.
        let titleExpression = NSExpression(forKeyPath: ExpressionKeys.title.rawValue)
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        
        let titleSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: titleExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(titleSearchComparisonPredicate)
        
        let districtExpression = NSExpression(forKeyPath: ExpressionKeys.district.rawValue)
        
        let districtSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: districtExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(districtSearchComparisonPredicate)
        
        let addressExpression = NSExpression(forKeyPath: ExpressionKeys.address.rawValue)
        
        let addressSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: addressExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(addressSearchComparisonPredicate)
        
        let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
        
        return orMatchPredicate
    }
}
