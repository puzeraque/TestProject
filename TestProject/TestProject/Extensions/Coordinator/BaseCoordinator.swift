import UIKit

class BaseCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []

    func start() {
    }

    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isNotEmpty,
            let coordinator = coordinator
        else { return }

        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: childCoordinators.count - index - 1)
            break
        }
    }

    func removeDependency<T: Coordinator>(of coordinatorType: T.Type) {
        guard
            childCoordinators.isNotEmpty
        else { return }

        for (index, element) in childCoordinators.reversed().enumerated() where type(of: element) == coordinatorType {
            childCoordinators.remove(at: childCoordinators.count - index - 1)
            break
        }
    }

    func removeAllDependencies() {
        childCoordinators.removeAll()
    }

    override init() { }
}
