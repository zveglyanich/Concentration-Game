//
//  ConcentrationThemeChooserViewController.swift
//  concentration
//
//  Created by Павел Звеглянич on 11.08.2020.
//  Copyright © 2020 Павел Звеглянич. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        "Faces" : "😁🥰🙃😝😡😱😭🤢",
        "Animals" : "🐱🐷🐸🐵🐥🦋🐟🦀",
        "Weather" : "🔥🌪🌈❄️🌬🌩☁️☔️"
    ]
    
    
    override func awakeFromNib() {
        //делегат контроллера представления, вызывается для каждого выходящего объекта
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            return cvc.theme == nil
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {//изменяем для ipad
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController { //изменяем для айфона
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)// перенос в навигайшен без переключения
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender) //пихаем в сегвей титл выюранной кнопки
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? { //
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController : ConcentrationViewController?// последний выбранный контроллер
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // выбор темы
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController{
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc//кмтанавливаем последний контроллер в кучу
                    }
                }
        }
    }
}
