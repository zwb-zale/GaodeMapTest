//
//  MaxinwinCar.swift
//  MaxWin
//
//  Created by maxwin on 2021/10/18.
//

class MaxinwinCar: Decodable {
    public var id: String?
    public var carid: String?
    enum CodingKeys: String, CodingKey {
        case id
        case carid
    }
    init() {}
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(String.self, forKey: .id)
        carid = try? container.decode(String.self, forKey: .carid)
    }
}
struct Car: Encodable, Identifiable {
    var id: String
    var name: String
}
