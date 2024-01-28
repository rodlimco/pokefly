//
//  APIPokemonDetail.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 26/1/24.
//

import Foundation

struct APIPokemonDetail: Codable {
    let abilities: [APIAbility]
    let id: Int
    let moves: [APIMove]
    let name: String
    let sprites: APISprites
    let types: [APIType]
    
    struct APIAbility: Codable {
        let ability: APIAbilityInfo

        struct APIAbilityInfo: Codable {
            let name: String
        }
    }

    struct APIMove: Codable {
        let move: APIMoveInfo

        struct APIMoveInfo: Codable {
            let name: String
        }
    }

    struct APISprites: Codable {
        let backDefault: String?
        let frontDefault: String?
        let other: APIOther?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case frontDefault = "front_default"
            case other
        }

        struct APIOther: Codable {
            let dreamWorld: APIDreamWorld?
            let officialArtwork: APIOfficialArtwork?
            
            enum CodingKeys: String, CodingKey {
                case dreamWorld = "dream_world"
                case officialArtwork = "official-artwork"
            }

            struct APIDreamWorld: Codable {
                let frontDefault: String?
                let frontFemale: String?
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                    case frontFemale = "front_female"
                }
            }

            struct APIOfficialArtwork: Codable {
                let frontDefault: String?
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
    }

    struct APIType: Codable {
        let type: APITypeInfo
        
        struct APITypeInfo: Codable {
            let name: String
        }
    }
}
