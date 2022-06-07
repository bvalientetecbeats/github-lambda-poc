package com.levelgoals.alloyevaluation.services

import com.levelgoals.bigbangdb.BigBangDbClient
import org.jetbrains.exposed.sql.Transaction

private const val USER = "application_service"

private val client = createClient()

fun <ReturnType> bbdbTransaction(statement: Transaction.() -> ReturnType) = client.transaction(statement)

private fun createClient(): BigBangDbClient {
    val password = getParam(ParameterStoreParam.bbdbPassword)

    return BigBangDbClient(USER, password)
}
