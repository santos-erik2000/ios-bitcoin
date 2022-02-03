//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    var coinManager = CoinManager()

    @IBOutlet weak var countriesPickerView: UIPickerView!
    @IBOutlet weak var countryBytecoinLabel: UILabel!
    @IBOutlet weak var valorBytecoinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        countriesPickerView.dataSource = self
        countriesPickerView.delegate = self
    }
    
    // Numero de colunas do Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Quantidade do Picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // Conteudo em cada Linha
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //Pega o Conteudo selecionado
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let countrySelec = coinManager.currencyArray[row]
        coinManager.getCoindPrice(for: countrySelec)
    }

    func didUpdateCoin(of coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.countryBytecoinLabel.text = coinModel.countyName
            self.valorBytecoinLabel.text = String(format: "%.2f", coinModel.bitCoin)
        }
    }

}

