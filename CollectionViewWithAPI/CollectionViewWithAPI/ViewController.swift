//
//  ViewController.swift
//  CollectionViewWithAPI
//
//  Created by Demo 01 on 19/05/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionAPi: UICollectionView!
    var arrProduct = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    func getData()
     {
        let url = URL(string: "https://fakestoreapi.com/products")
        URLSession.shared.dataTask(with: url!){ data, response, error in
            
            if let data = data , error == nil
            {
                do {
                    self.arrProduct = try JSONDecoder().decode([Product].self, from: data)
                    print(self.arrProduct)
                }
                catch{
                    print("error....",error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.collectionAPi.reloadData()
                }
            }
        }.resume()
    }

}



extension ViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellAPI
        cell.titleLbl.text = arrProduct[indexPath.row].title
//        cell.priceLbl.text = "$\(arrProduct[indexPath.row].price)"
        cell.priceLbl.text = "\(arrProduct[indexPath.row].price)"
        cell.image.image = UIImage(named: arrProduct[indexPath.row].image)
        
        let urlImg = URL(string: arrProduct[indexPath.row].image)
        cell.image.downloadImageFromJSON1(from: urlImg!)
        
        cell.image.layer.cornerRadius = 10
        cell.image.layer.borderWidth = 3
        cell.image.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    
}
extension UIImageView{
    func downloadImageFromJSON1(from url : URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            guard let httpURLresponse = response as? HTTPURLResponse, httpURLresponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image  = UIImage(data: data)
                else{
                    print("error occured while accessing img....")
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
extension ViewController:UICollectionViewDelegateFlowLayout
{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collcetionWIdth = collectionAPi.bounds.width
//        return CGSize (width: collcetionWIdth / 2 - 1, height: collcetionWIdth / 2 - 1)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 2, bottom: 0, right: 2)
//    }
}
