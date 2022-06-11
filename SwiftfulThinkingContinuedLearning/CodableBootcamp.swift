//
//  CodableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-11.
//

import SwiftUI

// Codable = Decodable + Encodable
struct CustomerModel: Identifiable, /*Decodable, Encodable*/ Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // Codable does the CodingKeys enum, inital init, encodable and decodable functions in the background
    /*
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
        case isPremium
        // if we want to assign a value as we get the key
        //case isPremium = "is_premium"
    }
    
    // Default initializer
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    // Initializer for Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    // Encodable function
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
    }
     */
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil //CustomerModel(id: "001", name: "Nick", points: 5, isPremium: true)
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        
        // Print the data
        /* print("JSON Data: ")
        print(data)
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString) */
        
        // Manually decode the data
        /* if
            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
            let dictionary = localData as? [String: Any], // cast into dictionary
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let points = dictionary["points"] as? Int,
            let isPremium = dictionary["isPremium"] as? Bool {
            // Instead of defaulting to a value, put everything in the if
            //let id = dictionary["id"] as? String ?? "empty"
            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
            customer = newCustomer
        } */
        
        // Decode the data using a JSON decoder
        /* do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("Error decoding: \(error)")
        } */
        // Decode the data using a JSON decoder in 1 line
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
    }
    
    func getJSONData() -> Data? {
        // We use the encoder to make fake JSON data
        let customer = CustomerModel(id: "125", name: "Emily", points: 500, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        
        // We make some fake JSON data, manually
        /* let dictionary: [String:Any] = [
            "id" : "1234",
            "name" : "Joe",
            "points" : 300,
            "isPremium" : true
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) */
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            if let customer = vm.customer {
                Text("Id: \(customer.id)")
                Text("Name: \(customer.name)")
                Text("Points: \(customer.points)")
                Text("Is premium: \(customer.isPremium.description)")
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
