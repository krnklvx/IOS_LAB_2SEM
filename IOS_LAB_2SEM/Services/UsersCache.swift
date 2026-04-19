//
//  UsersCache.swift
//  IOS_LAB_2SEM
//

import Foundation
import os.log

actor UsersCache {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "IOS_LAB_2SEM", category: "UsersCache")

    private var storage: [Int: User] = [:]
    private var inFlightIds: Set<Int> = [] //запущенные айди

    private let maxParallelFetches: Int
    private var activeFetches = 0

    init(maxParallelFetches: Int = 3) {
        self.maxParallelFetches = max(1, maxParallelFetches)
    }

    func user(for id: Int) -> User? {
        if let user = storage[id] {
            logger.info("user(for:) — hit, id=\(id, privacy: .public)") //из кэша
            return user
        }
        logger.debug("user(for:) — miss, id=\(id, privacy: .public)")
        return nil
    }

    func save(_ user: User) { //в кэш
        storage[user.id] = user
        logger.info("save(_:) — saved, id=\(user.id, privacy: .public)")
    }

    func loadUser(
        id: Int,
        fetch: @Sendable @escaping (Int) async throws -> User
    ) async throws -> User {
        if let cached = storage[id] { //из кэша
            logger.info("loadUser — cache hit, id=\(id, privacy: .public)")
            return cached
        }

        while inFlightIds.contains(id) { //если запрос для айди выполняется
            logger.debug("loadUser — waiting duplicate id=\(id, privacy: .public)")
            try Task.checkCancellation() //проверяем отмену
            try await Task.sleep(nanoseconds: 100_000_000)
            if let cached = storage[id] { //наличие реза в кэше каждую 0.1 сек
                return cached
            }
        }

        while activeFetches >= maxParallelFetches { //если достигнут лимит
            try Task.checkCancellation()
            try await Task.sleep(nanoseconds: 100_000_000) //ждем
        }

        inFlightIds.insert(id) //для айди начата загрузка
        activeFetches += 1
        logger.info("loadUser — cache miss, start fetch, id=\(id, privacy: .public)")

        do {
            let user = try await fetch(id) //передаем замыкание
            save(user) //сохр в кэш
            logger.info("loadUser — fetch success, id=\(id, privacy: .public)")
            inFlightIds.remove(id)
            activeFetches -= 1
            return user
        } catch {
            inFlightIds.remove(id)
            activeFetches -= 1
            logger.error("loadUser — fetch error id=\(id, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }
    }
}
