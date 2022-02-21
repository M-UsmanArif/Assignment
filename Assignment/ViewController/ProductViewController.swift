

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
  
  //MARK:- Outlets
  @IBOutlet weak var productCollectionView: UICollectionView!
  @IBOutlet weak var totalLbl: UILabel!
  
  //MARK:- Properties
  var productArray = [ProductModel]()
  var total = 0.0
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let url = "https://fakestoreapi.com/products"
      getData(url: url)
    }
    
  //MARK:- Actions
  func getData(url: String){
    print(url)
    Networking.instance.getAPICall(url: url){(response, error, status) in
      if error == nil && status == 200{
        guard let jsonDic = response.array else{return}
        //if let results = jsonDic[""]?.array{
        for item in jsonDic{
            let id = item["id"].int ?? 0
            let title = item["title"].string ?? ""
            let price = item["price"].double ?? 0
            let desc = item["description"].string ?? ""
            let cat = item["category"].string ?? ""
            let image = item["image"].string ?? ""
            let ratings = item["rating"].dictionary
            let rate = ratings?["rate"]?.floatValue ?? 0
            let count = ratings?["count"]?.int ?? 0
            
            let productDetails = ProductModel.init(id: id, title: title, price: price, description: desc, category: cat, imageURL: image, rate: rate, count: count)
            self.productArray.append(productDetails)
            
          }
        //}
      }
      else{
        print(error!)
      }
      self.productCollectionView.reloadData()
    }
  }
  
  @objc func buyBtnTapped(sender: UIButton){
    let price = productArray[sender.tag].price + total
    self.totalLbl.text = "\(round(price))"
    total = price
  }

}

//MARK:- CollectionView Delegates
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print(productArray.count)
    return productArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
    cell.layer.cornerRadius = 6
    cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    cell.layer.borderWidth = 2
    let instance = productArray[indexPath.row]
    let url = instance.imageURL
    cell.productImageView.sd_setImage(with: URL(string: url))
    cell.productTitleLbl.text = instance.title
    cell.productPriceLbl.text = "\(instance.price)"
    cell.countLbl.text = "\(instance.count)"
    
    cell.cosmosView.settings.fillMode = .precise
    cell.cosmosView.rating = Double(instance.rate)
    
    cell.buyBtn.layer.cornerRadius = 6
    cell.buyBtn.tag = indexPath.row
    cell.buyBtn.addTarget(self, action: #selector(buyBtnTapped(sender:)), for: .touchUpInside)
    return cell
  }
  
}

