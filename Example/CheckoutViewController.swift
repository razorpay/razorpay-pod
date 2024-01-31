//
//  CheckoutViewController.swift
//  Razorpay-Swift-Example
//
//  Created by Sachin Nautiyal on 08/07/20.
//  Copyright © 2020 Razorpay. All rights reserved.
//

import UIKit
import Razorpay
import SafariServices

class CheckoutViewController: UIViewController,RazorpayPaymentCompletionProtocolWithData {
    
    var razorpayObj : RazorpayCheckout? = nil
    var merchantDetails : MerchantsDetails = MerchantsDetails.getDefaultData()
    
    let razorpayKey = "rzp_test_1DP5mmOlF5G5ag" // Sign up for a Razorpay Account(https://dashboard.razorpay.com/#/access/signin) and generate the API Keys(https://razorpay.com/docs/payment-gateway/dashboard-guide/settings/#api-keys/) from the Razorpay Dashboard.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Don't use viewDidLoad method for calling open method, use viewWillAppear instead,
    // as it will give you this error - "Warning: Attempt to present < finishViewController: 0x1e56e0a0 > on < ViewController: 0x1ec3e000> whose view is not in the window hierarchy!".
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLogo()
    }
    
    func setupLogo() {
        let image = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: image)
    }
    
    @IBAction func payNowButtonAction(_ sender: UIButton) {
        self.openRazorpayCheckout()
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toSettingsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SettingsTableViewController {
            controller.delegate = self
        }
    }
    
    @IBAction func toSafariControllerAction(_ sender: Any) {
        guard let url = URL(string: "https://docs.razorpay.com") else { return }
        let controller = SFSafariViewController(url: url)
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
    
    private func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    private func openRazorpayCheckout() {
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        razorpayObj = RazorpayCheckout.initWithKey(razorpayKey, andDelegateWithData: self)
        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": "1234567890",
                "email": "a@a.com"
            ],
            "image": merchantDetails.logo,
            "amount" : 100,
            "name": merchantDetails.name,
            "theme": [
                "color": merchantDetails.color.toHexString()
            ]
            // follow link for more options - https://razorpay.com/docs/payment-gateway/web-integration/standard/checkout-form/
        ]
        if let rzp = self.razorpayObj {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        self.presentAlert(withTitle: "Payment Successful", message: response?.description)
    }
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        self.presentAlert(withTitle: "Payment Failed", message: str+"\n"+response!.description)
    }
}

extension CheckoutViewController : CustomizeDataDelegate {
    
    func dataChanged(with merchantDetails: MerchantsDetails) {
        self.merchantDetails = merchantDetails
    }
    
}

// RazorpayPaymentCompletionProtocol - This will execute two methods 1.Error and 2. Success case. On payment failure you will get a code and description. In payment success you will get the payment id.
//extension CheckoutViewController : RazorpayPaymentCompletionProtocol {
//    
//    func onPaymentError(_ code: Int32, description str: String) {
//        print("error: ", code, str)
//        self.presentAlert(withTitle: "Alert", message: str)
//    }
//    
//    func onPaymentSuccess(_ payment_id: String) {
//        print("success: ", payment_id)
//        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
//    }
//}

// RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
//extension CheckoutViewController: RazorpayPaymentCompletionProtocolWithData {
//    
//    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
//        print("error: ", code)
//        self.presentAlert(withTitle: "Alert", message: str)
//    }
//    
//    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
//        print("success: ", payment_id)
//        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
//    }
//}


extension CheckoutViewController {
//    func presentAlert(withTitle title: String?, message : String?) {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            let OKAction = UIAlertAction(title: "Okay", style: .default)
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
}

extension CheckoutViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
