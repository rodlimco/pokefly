//
//  MockURLProtocol.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation

class MockURLProtocol: URLProtocol {

    public static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override public class func canInit(with _: URLSessionTask) -> Bool {
        true
    }

    override public class func canInit(with _: URLRequest) -> Bool {
        true
    }

    override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override public func startLoading() {

        do {
            if let (response, data) = try MockURLProtocol.requestHandler?(request) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override public func stopLoading() {}
}
