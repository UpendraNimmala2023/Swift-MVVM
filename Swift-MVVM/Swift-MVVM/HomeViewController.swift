//
//  ViewController.swift
//  Swift-MVVM
//
//  Created by Upendra Nimmala on 3/13/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTView: UITableView!
    var productsResponse: ProductsResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // UITableview Registration
        homeTView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        Task {
            do {
                productsResponse = try await fetchAPIResponse()
                homeTView.reloadData()
            }catch {
                throw ProductErrorHandler.invalidResponse("Invalid data")
            }
            
        }
    }

}
func fetchAPIResponse() async throws -> ProductsResponse {
    let endpoint = "https://dummyjson.com/products"
    guard let url = URL(string: endpoint) else {
        throw ProductErrorHandler.invalidError("InvalidUrl")
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw ProductErrorHandler.invalidResponseCode
    }
    do {
        return try JSONDecoder().decode(ProductsResponse.self, from: data)
    }catch {
        throw ProductErrorHandler.invalidResponse("Invalid Data")
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsResponse?.products.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = productsResponse?.products[indexPath.row].brand ?? "Upendra"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        //print(tableView.cellForRow(at: indexPath.row))
    }
}

struct ProductsResponse: Codable {
    let products: [EachProductResponse]
    let total: Int
    let limit: Int
    
}
struct EachProductResponse: Codable {
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}
enum ProductErrorHandler: Error {
    case invalidError(String)
    case invalidResponse(String)
    case invalidResponseCode
}
