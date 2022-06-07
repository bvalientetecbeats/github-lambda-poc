package com.levelgoals.alloyevaluation.utils

import com.levelgoals.utils.LocalDateSerializer
import com.levelgoals.utils.UuidSerializer
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.client.request.setBody
import io.ktor.http.ContentType
import io.ktor.http.contentType
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObjectBuilder
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.encodeToJsonElement
import kotlinx.serialization.modules.SerializersModule
import kotlinx.serialization.modules.contextual
import org.slf4j.LoggerFactory

val json = Json {
    serializersModule = SerializersModule {
        contextual(LocalDateSerializer)
        contextual(UuidSerializer)
    }
}

val logger = LoggerFactory.getLogger("Alloy Evaluation Function")!!

inline fun <reified BodyType> HttpRequestBuilder.setJsonBody(body: BodyType) {
    contentType(ContentType.Application.Json)
    setBody(body)
}

inline fun <reified SerializableType> JsonObjectBuilder.putSerializable(key: String, value: SerializableType) =
    put(key, json.encodeToJsonElement(value))

val JsonPrimitive.bigDecimal get() = content.toBigDecimal()
