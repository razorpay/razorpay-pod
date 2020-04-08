//
//  ViewController.swift
//  Example
//
//  Created by Sachin Nautiyal on 03/02/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit
import Razorpay

class ViewController : UIViewController {
    
//     var razorpayObj : Razorpay? = nil
    var razorpayObj: RazorpayCheckout!

    let defaultHeight : CGFloat = 40
    let defaultWidth : CGFloat = 120
    
    let razorpayKey = "" // Sign up for a Razorpay Account(https://dashboard.razorpay.com/#/access/signin) and generate the API Keys(https://razorpay.com/docs/payment-gateway/dashboard-guide/settings/#api-keys/) from the Razorpay Dashboard.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCheckoutButton()
    }
    
    // Don't use viewDidLoad method for calling open method, use viewWillAppear instead,
    // as it will give you this error - "Warning: Attempt to present < finishViewController: 0x1e56e0a0 > on < ViewController: 0x1ec3e000> whose view is not in the window hierarchy!".
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupCheckoutButton() {
        let buyButton = UIButton(type: .custom)
        buyButton.setTitle("Checkout", for: .normal)
        buyButton.setTitleColor(.blue, for: .normal)
        self.view.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.heightAnchor.constraint(equalToConstant: self.defaultHeight),
            buyButton.widthAnchor.constraint(equalToConstant: self.defaultWidth),
            buyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        buyButton.addTarget(self, action: #selector(openCheckoutAction(_:)), for: .touchUpInside)
    }
    
    @IBAction func openCheckoutAction(_ sender: UIButton) {
        self.openRazorpayCheckout()
    }
    
    private func openRazorpayCheckout() {
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
//         razorpayObj = Razorpay.initWithKey(razorpayKey, andDelegate: self)
        razorpayObj = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)

        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": "1234567890",
                "email": "a@a.com"
                //                "method":"wallet",
                //                "wallet":"amazonpay"
            ],
            "image": "http://www.freepngimg.com/download/light/2-2-light-free-download-png.png",
            "amount" : 100,
            "timeout":10,
            "theme": [
                "color": "#F37254"
            ]//            "order_id": "order_B2i2MSq6STNKZV"
            // and all other options
        ]
        if let rzp = self.razorpayObj {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
}

// RazorpayPaymentCompletionProtocol - This will execute two methods 1.Error and 2. Success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension ViewController : RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}

// RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension ViewController: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}


extension ViewController {
    func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
