//
//  SearchStoreTests.swift
//  PokedexTests
//
//  Created by Breno Valadão on 27/11/21.
//

import XCTest
import Pokedex
import Combine

class SearchStoreTests: XCTestCase {

    typealias SearchError = SearchStore.SearchError
    
    let userDefaults = UserDefaults(suiteName: "pokemon.tests.suite.name")!
    let jsonLoader = JSONLoader()
    var cancellables = [AnyCancellable]()

    override func setUp() {
        userDefaults.clearAllKeys()
    }
    
    func test_searchStoreInitialState() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.state == .initial)
    }
    
    func test_searchStoreFetchRandomPokemonActionWithSuccessResponse() {
        let sut = makeSUT()
        let pokemon = PokemonsFactory.getPokemonFromLocalJSON()
        
        sut.fetchRandomPokemon()
        XCTAssertTrue(sut.state == .loading)
        
        let exp = expectation(description: "Complete request with loaded state")
        
        sut.$state.sink { state in
            if state == .loaded(pokemon, isAlreadyCaptured: false) {
                exp.fulfill()
            }
        }
        .store(in: &cancellables)
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func test_searchStoreFetchRandomPokemonActionWithFailureResponse() {
        let sut = makeSUT(shouldFailRequests: true)
        
        sut.fetchRandomPokemon()
        XCTAssertTrue(sut.state == .loading)
        
        let exp = expectation(description: "Complete request with error state")
        
        sut.$state.sink { state in
            if state == .failure(SearchError.errorRetrievingRandomPokemon) {
                exp.fulfill()
            }
        }
        .store(in: &cancellables)
        
        wait(for: [exp], timeout: 0.5)
    }
    
    func test_searchStoreCapturePokemonWithSuccess() {
        let sut = makeSUT()
        let pokemon = PokemonsFactory.getPokemonFromLocalJSON()
                
        sut.state = .loaded(pokemon, isAlreadyCaptured: false)
        
        sut.captureCurrentPokemon()

        XCTAssertTrue(sut.state == .captured(pokemon))
    }
    
    func test_searchStoreCapturePokemonWithAlreadyCapturedPokemon() {
        let sut = makeSUT()
        let pokemon = PokemonsFactory.getPokemonFromLocalJSON()
                
        sut.state = .loaded(pokemon, isAlreadyCaptured: true)
        
        sut.captureCurrentPokemon()
        
        XCTAssertTrue(sut.state == .loaded(pokemon, isAlreadyCaptured: true), "The state shouldn't change")
    }
    
    // MARK: - Factories
    
    func makeSUT(shouldFailRequests: Bool = false) -> SearchStore {
        registerMockManagers(shouldFailRequests: shouldFailRequests)
        let searchStore = SearchStore()
        return searchStore
    }
    
    func registerMockManagers(shouldFailRequests: Bool) {
        DIContainer.shared.register(APIManaging.self, cached: true) {
            APIManagerMock(shouldFail: shouldFailRequests)
        }
        
        DIContainer.shared.register(CacheManaging.self, cached: true) {
            CacheManager(userDefaults: self.userDefaults)
        }
    }
}

extension SearchStore.State: Equatable {
    public static func == (lhs: SearchStore.State, rhs: SearchStore.State) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial),
             (.loading, .loading):
            return true
        
        case (let .loaded(lhsPokemon, lhsIsAlreadyCaptured), let .loaded(rhsPokemon, rhsIsAlreadyCaptured)):
            return lhsPokemon == rhsPokemon && lhsIsAlreadyCaptured == rhsIsAlreadyCaptured
        
        case (let .captured(lhsPokemon), let .captured(rhsPokemon)):
            return lhsPokemon == rhsPokemon
        
        case (let .failure(lhsError), let .failure(rhsError)):
            return lhsError == rhsError
            
        default:
            return false
        }
    }
}
