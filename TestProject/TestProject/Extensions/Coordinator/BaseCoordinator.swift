import UIKit
// Abstract coordinator class

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

extension BaseCoordinator {
    func deepContains<C: BaseCoordinator>(child _: C.Type) -> Bool {
        guard childCoordinators.isNotEmpty,
              type(of: self) != C.self  else {
            return type(of: self) == C.self
        }

        var isContains = false

        for coordinator in childCoordinators {
            guard (coordinator as? BaseCoordinator)?.deepContains(child: C.self) == true else { continue }
            isContains = true
            break
        }

        return isContains
    }

    func contains<C: Coordinator>(child _: C.Type) -> Bool {
        return childCoordinators.contains(where: { type(of: $0) == C.self })
    }

    func child<C: Coordinator>(ofType _: C.Type) -> C? {
        return childCoordinators.first(where: { type(of: $0) == C.self }) as? C
    }
}
