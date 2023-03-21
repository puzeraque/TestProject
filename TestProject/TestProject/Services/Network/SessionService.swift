import Foundation

final class SessionService {
    private let session = URLSession.shared

    func task(
        url: URL,
        resultCompletion: @escaping ((Result<Data, Error>) -> Void)
    ) {
        let request = URLRequest(url: url)
        let task = session.dataTask(
            with: request as URLRequest,
            completionHandler: { data, response, error in
                if let error = error {
                    print(error)
                    resultCompletion(.failure(error))
                    return
                }
                guard let data = data else { return }
                resultCompletion(.success(data))
            }
        )
        task.resume()
    }
}
