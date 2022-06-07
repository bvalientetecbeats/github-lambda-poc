package com.levelgoals.alloyevaluation.services

import software.amazon.awssdk.enhanced.dynamodb.DynamoDbEnhancedClient
import software.amazon.awssdk.enhanced.dynamodb.TableSchema
import software.amazon.awssdk.enhanced.dynamodb.mapper.annotations.DynamoDbBean
import software.amazon.awssdk.enhanced.dynamodb.mapper.annotations.DynamoDbPartitionKey
import java.util.UUID

@DynamoDbBean
data class SsnItem(
    @get:DynamoDbPartitionKey var userId: UUID? = null,
    var ssn: String? = null
)

private object Table {
    val ssns = client.table("ssns", TableSchema.fromClass(SsnItem::class.java))!!
}

private val client = DynamoDbEnhancedClient.create()

fun getSsnItem(userId: UUID): SsnItem? = Table.ssns.getItem { builder ->
    builder
        .key { it.partitionValue(userId.toString()) }
        .consistentRead(true)
}
