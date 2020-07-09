//
//  SettingsTableViewController.swift
//  Razorpay-Swift-Example
//
//  Created by Sachin Nautiyal on 08/07/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit

protocol CustomizeDataDelegate {
    func dataChanged(with merchantDetails : MerchantsDetails)
}

struct MerchantsDetails {
    let name : String
    let logo : String
    let color : UIColor
}

extension MerchantsDetails {
    
    static func getDefaultData() -> MerchantsDetails {
        let details = MerchantsDetails(name: "Demo App",
                                       logo: "https://pbs.twimg.com/profile_images/1271385506505347074/QIc_CCEg_400x400.jpg",
                                       color: .blue)
        return details
    }
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var urlTextFieldOutlet: UITextField!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var companyNameTextFieldOutlet: UITextField!
    @IBOutlet weak var colorCodeLabelOutlet: UILabel!
    @IBOutlet weak var colorSampleViewOutlet: UIView!
    
    var delegate: CustomizeDataDelegate?
    
    // MARK: - Color Matrix (only for test case)
    var colorMatrix = [ [UIColor]() ]
    private func fillColorMatrix(numX: Int, _ numY: Int) {
        colorMatrix.removeAll()
        if numX > 0 && numY > 0 {
            
            for _ in 0..<numX {
                var colInX = [UIColor]()
                for _ in 0..<numY {
                    colInX += [UIColor.randomColor()]
                }
                colorMatrix += [colInX]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLogo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            let merchantObj = MerchantsDetails(name: self.companyNameTextFieldOutlet.text ?? "Demo App", logo: urlTextFieldOutlet.text ?? "https://pbs.twimg.com/profile_images/1271385506505347074/QIc_CCEg_400x400.jpg", color: self.colorSampleViewOutlet.backgroundColor ?? .blue)
            if let delegate = delegate {
                delegate.dataChanged(with: merchantObj)
            }
        }
    }
    
    func setupLogo() {
        let image = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: image)
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        let colorPickerVC = SwiftColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.modalPresentationStyle = .popover
        let popVC = colorPickerVC.popoverPresentationController!;
        popVC.sourceRect = sender.frame
        popVC.sourceView = self.view
        popVC.permittedArrowDirections = .any;
        popVC.delegate = self;
        self.present(colorPickerVC, animated: true, completion: nil)
    }
    
    func loadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.imageViewOutlet.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension SettingsTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.urlTextFieldOutlet {
            if let urlString = textField.text, let url = URL(string: urlString) {
                self.loadImage(from: url)
            }
        }
        textField.resignFirstResponder()
        return true
    }
}

extension SettingsTableViewController: UIPopoverPresentationControllerDelegate, SwiftColorPickerDelegate, SwiftColorPickerDataSource
{
    // MARK: - Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = segue.identifier {
            // adding as delegate for color selection
            let colorPickerVC = segue.destination as! SwiftColorPickerViewController
            colorPickerVC.delegate = self
            colorPickerVC.dataSource = self
            
            if let popPresentationController = colorPickerVC.popoverPresentationController {
                popPresentationController.delegate = self
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: popover presenation delegates
    
    // this enables pop over on iphones
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.none
    }
    
    // MARK: - Swift Color Picker Data Source
    func colorForPalletIndex(x: Int, y: Int, numXStripes: Int, numYStripes: Int) -> UIColor {
        
        if colorMatrix.count > x  && x >= 0 {
            let colorArray = colorMatrix[x]
            if colorArray.count > y && y >= 0 {
                return colorArray[y]
            } else {
                fillColorMatrix(numX: numXStripes,numYStripes)
                return colorForPalletIndex(x: x, y:y, numXStripes: numXStripes, numYStripes: numYStripes)
            }
        } else {
            fillColorMatrix(numX: numXStripes,numYStripes)
            return colorForPalletIndex(x: x, y:y, numXStripes: numXStripes, numYStripes: numYStripes)
        }
    }
    
    // MARK: Color Picker Delegate
    func colorSelectionChanged(selectedColor color: UIColor) {
        self.colorSampleViewOutlet.backgroundColor = color
        self.colorCodeLabelOutlet.text = color.toHexString()
    }
}
