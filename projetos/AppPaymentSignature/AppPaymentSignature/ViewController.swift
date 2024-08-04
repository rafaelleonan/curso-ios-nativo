//
//  ViewController.swift
//  AppPaymentSignature
//
//  Created by Davi Orzechowski on 07/06/24.
//

import UIKit
import StoreKit

class ViewController: UIViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver {
    @IBOutlet weak var checklabels:UIView!
    @IBOutlet weak var spinnerlabel:UILabel!
    @IBOutlet weak var spinner:UIActivityIndicatorView!
    @IBOutlet weak var subscribeButton:UIButton!
    @IBOutlet weak var termsButton:UIButton!
    @IBOutlet weak var privacyButton:UIButton!
    @IBOutlet weak var restoreButton:UIButton!
    @IBOutlet weak var titledesc:UILabel!
    @IBOutlet weak var desc1:UILabel!
    @IBOutlet weak var desc2:UILabel!
    @IBOutlet weak var supertitle:UILabel!
    var validProduct:SKProduct!
    var buttonTitle = ""

    override func viewWillAppear(_ animated: Bool) {
        spinner.isHidden = false
        spinnerlabel.isHidden = false
        checklabels.isHidden = true
        subscribeButton.isHidden = true
        privacyButton.isHidden = true
        termsButton.isHidden = true
        restoreButton.isHidden = true
        buttonTitle = ""
        spinner.startAnimating()
        spinnerlabel.text = "Buscando assinaturas..."
        let request = SKProductsRequest.init(productIdentifiers: Set.init(["br.com.daviorze.payment"]))
        request.delegate = self
        request.start()
    }
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async(execute: {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.spinnerlabel.isHidden = true
            self.checklabels.isHidden = false
            if(response.products.count > 0){
                self.validProduct = response.products[0]
                let numberFormatter = NumberFormatter()
                numberFormatter.formatterBehavior = .behavior10_4
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = self.validProduct.priceLocale
                let formattedstring = numberFormatter.string(from: self.validProduct.price) ?? ""
                self.buttonTitle = String.init(format: "%@ %@%@", "ASSINAR POR",formattedstring,"/mês")
                self.subscribeButton.setTitle(self.buttonTitle, for: .normal)
                self.subscribeButton.isHidden = false
                self.restoreButton.isHidden = false
                self.termsButton.isHidden = false
                self.privacyButton.isHidden = false
            } else {
                print("Erro ao buscar as assinaturas")
            }
        })
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchasing:
                DispatchQueue.main.async(execute: {
                    self.spinnerlabel.text = "Realizando compra..."
                })
                break
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Pagamento feito com sucesso, ir para próxima tela")
                DispatchQueue.main.async(execute: {
                    self.spinner.isHidden = true;
                    self.spinnerlabel.isHidden = true;
                    self.spinner.stopAnimating()
                    self.checklabels.isHidden = false;
                    self.subscribeButton.isHidden = false;
                    self.privacyButton.isHidden = false;
                    self.restoreButton.isHidden = false;
                    self.termsButton.isHidden = false;
                })
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Restauração feita com sucesso, ir para próxima tela")
                DispatchQueue.main.async(execute: {
                    self.spinner.isHidden = true;
                    self.spinnerlabel.isHidden = true;
                    self.spinner.stopAnimating()
                    self.checklabels.isHidden = false;
                    self.subscribeButton.isHidden = false;
                    self.privacyButton.isHidden = false;
                    self.restoreButton.isHidden = false;
                    self.termsButton.isHidden = false;
                })
                break
            case .deferred:
                DispatchQueue.main.async(execute: {
                    self.subscribeButton.isHidden = false;
                    self.privacyButton.isHidden = false;
                    self.restoreButton.isHidden = false
                    self.termsButton.isHidden = false;
                    self.spinner.isHidden = true;
                    self.spinnerlabel.isHidden = true;
                    self.spinner.stopAnimating()
                    self.checklabels.isHidden = false;
                    if(transaction.error!._code == 2){
                        print("Pagamento cancelado pelo usuário no meio do processp")
                    } else {
                        NSLog("Erro no pagamento: %li: %@", transaction.error!._code,transaction.error!.localizedDescription)
                    }
                })
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .failed:
                DispatchQueue.main.async(execute: {
                    self.subscribeButton.isHidden = false;
                    self.privacyButton.isHidden = false;
                    self.restoreButton.isHidden = false
                    self.termsButton.isHidden = false;
                    self.spinner.isHidden = true;
                    self.spinnerlabel.isHidden = true;
                    self.spinner.stopAnimating()
                    self.checklabels.isHidden = false;
                    if(transaction.error!._code == 2){
                        print("Pagamento cancelado pelo usuário no meio do processp")
                    } else {
                        NSLog("Erro no pagamento: %li: %@", transaction.error!._code,transaction.error!.localizedDescription)
                    }
                })
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            default:
                DispatchQueue.main.async(execute: {
                    self.subscribeButton.isHidden = false;
                    self.privacyButton.isHidden = false;
                    self.restoreButton.isHidden = false
                    self.termsButton.isHidden = false;
                    self.spinner.isHidden = true;
                    self.spinnerlabel.isHidden = true;
                    self.spinner.stopAnimating()
                    self.checklabels.isHidden = false;
                })
            }
        }
    }
    @IBAction func subscribe(_ sender:Any){
        spinner.isHidden = false;
        spinnerlabel.isHidden = false;
        spinner.startAnimating()
        checklabels.isHidden = true;
        subscribeButton.isHidden = true;
        privacyButton.isHidden = true;
        restoreButton.isHidden = true;
        termsButton.isHidden = true;
        let payment = SKMutablePayment(product: validProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    @IBAction func restore(_ sender:Any){
        spinner.isHidden = false;
        spinnerlabel.isHidden = false;
        spinner.startAnimating()
        checklabels.isHidden = true;
        subscribeButton.isHidden = true;
        privacyButton.isHidden = true;
        restoreButton.isHidden = true;
        termsButton.isHidden = true;
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}

