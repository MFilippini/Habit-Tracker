//
//  SettingsViewController.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/24/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var paletteCollectionView: UICollectionView!
    var palatteIdentifier = 0
    let colorDisplayArray = ["purple","blue","green","yellow","orange","red"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        navigationController?.navigationBar.topItem?.title = "Settings"
        paletteCollectionView.delegate = self
        paletteCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return palettesTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = paletteCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PaletteCell
        cell.nameLabel.text = palettesTypes[indexPath.row]
        cell.colorView1.backgroundColor = colors["purple"]![indexPath.row]
        cell.colorView2.backgroundColor = colors["blue"]![indexPath.row]
        cell.colorView3.backgroundColor = colors["green"]![indexPath.row]
        cell.colorView4.backgroundColor = colors["yellow"]![indexPath.row]
        cell.colorView5.backgroundColor = colors["orange"]![indexPath.row]
        cell.colorView6.backgroundColor = colors["red"]![indexPath.row]
        cell.palette = indexPath.row
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
