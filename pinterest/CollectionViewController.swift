//
//  CollectionViewController.swift
//  pinterest
//
//  Created by Oscar on 4/3/19.
//  Copyright © 2019 Alumno IDS. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        //print("------- setteando controller ------")
        collectionView?.backgroundColor = .white
        collectionView?.register(pinCell.self, forCellWithReuseIdentifier: cellId )
        
    }
    
    let pines = ["Coche", "Pokemon GO", "Consejos", "Galaxia", "Lego car", "Paisaje", "San Agustin", "Laptop"]
    let imagenes = [#imageLiteral(resourceName: "auto_2"), #imageLiteral(resourceName: "meme_pokemon"), #imageLiteral(resourceName: "consejos fin de semestre 1"), #imageLiteral(resourceName: "Galaxia-Monstruosa"), #imageLiteral(resourceName: "lego_car"), #imageLiteral(resourceName: "paisaje"), #imageLiteral(resourceName: "san-agustin-de-hipona"), #imageLiteral(resourceName: "laptop_acer")]
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pines.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! pinCell
        
        cell.label1.text = pines[indexPath.item]
        let imageToUse : UIImage = imagenes[indexPath.item]
        cell.imageView1.image = imageToUse
        cell.imageView1.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("seleccionaste \(pines[indexPath.item])")
        animateCell(collectionView, indexPath: indexPath)
        changeScreen(indexPath: indexPath)
        
    }
    
    func changeScreen(indexPath: IndexPath){
        let pinDVC = pinDetailVC()
        pinDVC.pinImage.image = imagenes[indexPath.item]
        pinDVC.pinTitle.text = pines[indexPath.item]
        self.navigationController?.pushViewController(pinDVC, animated: true)
        
    }
    
    func animateCell(_ collectionView: UICollectionView, indexPath : IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! pinCell
        let currentCellWidth = cell.frame.size.width
        let currentCellHeight = cell.frame.size.height
        //print("size width:\(cell.frame.size.width)  height:\(cell.frame.size.height)")
        
        let newImageHeight2 = (self.view.frame.size.width * cell.bounds.height) / cell.bounds.width
        //print("++++++newImageHeight = ( \(self.view.frame.size.width) *  \(cell.bounds.height) ) / \(cell.bounds.width) = \(   ((self.view.frame.size.width * cell.bounds.height) / cell.bounds.width)  )")
        var newFrame = cell.frame
        let originalFrame = cell.frame
        
        UIView.animate(withDuration: 0.20, delay: 0, options: .curveEaseOut, animations: {
            newFrame = CGRect(x: 0, y: 10, width: (currentCellWidth * 2), height: (currentCellHeight * 2))
            cell.frame = newFrame
            cell.alpha = 0
            
            
        }, completion: {finished in
            cell.frame = originalFrame
            cell.alpha = 1
        })
    }
    
}


extension CollectionViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        //print("sacamos height de imagen \(indexPath.item)")
        return imagenes[indexPath.item].size.height
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        widthForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return imagenes[indexPath.item].size.width
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        currentPhotoWidth indexPath:IndexPath) -> CGFloat {
        return (((view.frame.width / 2) - 16) * 0.8)
        
    }
}
