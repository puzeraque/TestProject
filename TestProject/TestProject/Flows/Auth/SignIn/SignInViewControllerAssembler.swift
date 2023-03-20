enum SignInViewControllerAssembler {
    static func assembly() -> SignInViewController {
        let viewModel = SignInViewModel()
        let controller = SignInViewController(viewModel: viewModel)
        viewModel.view = controller
        return controller
    }
}
