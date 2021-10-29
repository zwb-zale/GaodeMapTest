//
//  Company.swift
//  MaxWin
//
//  Created by maxwin on 2021/10/20.
//

class Company: Decodable {
    public var id: String?
    public var name: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    init() {}
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(String.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
    }
}
