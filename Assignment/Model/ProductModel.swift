

import Foundation

class ProductModel{
  var id = Int()
  var title = String()
  var price = Double()
  var description = String()
  var category = String()
  var imageURL = String()
  //var rating = [RatingModel]()
  var rate = Float()
  var count = Int()
  
  
  init(id: Int, title: String, price: Double, description: String, category: String, imageURL: String, rate: Float, count: Int) {
    self.id = id
    self.title = title
    self.price = price
    self.description = description
    self.category = category
    self.imageURL = imageURL
    //self.rating = rating
    self.rate = rate
    self.count = count
  }
}
