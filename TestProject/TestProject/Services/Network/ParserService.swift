import Foundation

final class ParserService {
    private let sessionService = SessionService()
    private let jsonDecoder = JSONDecoder()

    func parse(
        requestType: RequestType,
        resultCompletion: @escaping ((Codable) -> Void)
    ) {
        guard let url = requestType.url else { return }
        sessionService.task(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {

                    let responseModel = try self.jsonDecoder.decode(
                        requestType.responseModelType,
                        from: data
                    )
                    resultCompletion(responseModel)
                } catch let error {
                    print(error)
                }

            case .failure(let failure):
                print(failure)
            }
        }
    }
}
