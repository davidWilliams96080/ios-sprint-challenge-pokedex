//
//  PokedexController.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation
import UIKit

class PokedexController {
    
    enum HTTPMethod: String {
           case get = "GET"
    }
    
   // private let baseURL = URL(string: "https://lambdapokeapi.herokuapp.com/")!
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func searchForPokemonWith(searchTerm: String, completion: @escaping ([Pokemon]) -> Void) {
          var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
          let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
          urlComponents?.queryItems = [searchTermQueryItem]
          guard let requestURL = urlComponents?.url else {
              print("Error: Request URL is nil")
              completion([Pokemon]())
              return
          }
          var request = URLRequest(url: requestURL)
          request.httpMethod = HTTPMethod.get.rawValue
          
          URLSession.shared.dataTask(with: request) { (data, _, error) in
              guard error == nil else {
                  print("Error fetching data: \(error!)")
                  completion([])
                  return
              }
              
              guard let data = data else {
                  print("Error: No data returned from data task.")
                  completion([])
                  return
              }
              
              let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
              do {
                  let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                  completion([pokemonSearch])
              } catch {
                  print("Unable to decode search: \(error)")
                  completion([])
              }
          }.resume()
      }
    
    func savePokemon(with newPokemon: Pokemon) {
        
    }
    
    
    
    
}
