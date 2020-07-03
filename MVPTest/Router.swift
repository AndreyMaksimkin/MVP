//
//  RouterProtocol.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 31/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(post: Post)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else {
                return
            }
            
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(post: Post) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(post: post, router: self) else {
                return
            }
            
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
