@file:UseSerializers(
    EpochMillisecondsSerializer::class,
    EvaluationOutcomeSerializer::class
)

package com.levelgoals.alloyevaluation.services

import com.levelgoals.alloyevaluation.utils.EpochMillisecondsSerializer
import com.levelgoals.alloyevaluation.utils.EvaluationOutcomeSerializer
import com.levelgoals.alloyevaluation.utils.bigDecimal
import com.levelgoals.alloyevaluation.utils.logger
import com.levelgoals.alloyevaluation.utils.putSerializable
import com.levelgoals.alloyevaluation.utils.setJsonBody
import com.levelgoals.bigbangdb.daos.Address
import com.levelgoals.bigbangdb.daos.AlloyEvaluation
import com.levelgoals.bigbangdb.daos.Application
import com.levelgoals.bigbangdb.daos.User
import com.levelgoals.bigbangdb.daos.UserMetadatum
import com.levelgoals.utils.Stage
import com.levelgoals.utils.stage
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.HttpRequestRetry
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.auth.Auth
import io.ktor.client.plugins.auth.providers.BasicAuthCredentials
import io.ktor.client.plugins.auth.providers.basic
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.defaultRequest
import io.ktor.client.request.header
import io.ktor.client.request.post
import io.ktor.http.URLProtocol
import io.ktor.http.path
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.buildJsonObject
import kotlinx.serialization.json.int
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.put
import kotlinx.serialization.json.putJsonObject
import java.time.Duration
import java.time.Instant
import java.util.Locale

@Serializable
data class Evaluation(
    @SerialName("evaluation_token") val token: String,
    @SerialName("entity_token") val entityToken: String,
    val timestamp: Instant,
    private val summary: Summary,
    @SerialName("formatted_responses") val formattedResponses: JsonObject,
    @SerialName("raw_responses") val rawResponses: JsonObject
) {
    @Serializable
    data class Summary(
        val outcome: AlloyEvaluation.Outcome
    )

    // Flatten the model for easier usage
    val outcome get() = summary.outcome
}

private object Header {
    const val ENTITY_TOKEN = "Alloy-Entity-Token"
}

private object Path {
    const val EVALUATIONS = "evaluations"
    const val VERSION = "v1"
}

private val HOST = when (stage) {
    Stage.prod -> "api.alloy.co"
    else -> "sandbox.alloy.co"
}
private const val ONBOARDING_WORKFLOW_TOKEN = "x7y6hDMC6XkeG4ueoraDjx1kNFOP7xJS"
private val TIMEOUT = Duration.ofSeconds(30)

private val client = createClient()
private val onboardingWorkflowSecret = getParam(ParameterStoreParam.alloyOnboardingWorkflowSecret)

suspend fun runOnboardingEvaluation(
    application: Application,
    user: User,
    address: Address,
    ssn: String,
    userMetadatum: UserMetadatum,
    decisionOnCredit: Boolean
): Evaluation {
    val requestBody = buildEvaluationRequestBody(application, user, address, ssn, userMetadatum, decisionOnCredit)
    val response = client.post(Path.EVALUATIONS) {
        header(Header.ENTITY_TOKEN, user.alloyEntityToken)
        setJsonBody(requestBody)
    }

    return response.body()
}

private fun buildEvaluationRequestBody(
    application: Application,
    user: User,
    address: Address,
    ssn: String,
    userMetadatum: UserMetadatum,
    decisionOnCredit: Boolean
) = buildJsonObject {
    put("name_last", user.lastName)
    put("name_first", user.firstName)
    put("email_address", user.email)
    put("phone_number", user.phone)
    put("address_line_1", address.line1)
    put("address_line_2", address.line2)
    put("address_city", address.city)
    put("address_state", address.state)
    put("address_postal_code", address.postalCode)
    put("address_country_code", Locale.US.country)
    putSerializable("birth_date", user.birthDate)
    put("document_ssn", ssn)
    put("ip_address_v4", userMetadatum.ipAddress)
    put("surescore", true)
    put("experian_decision", decisionOnCredit)
    put("user_consent", true)
    putJsonObject("meta") {
        putSerializable("userId", user.id.value)
        putSerializable("applicationId", application.id.value)
    }
}

private fun createClient() = HttpClient {
    expectSuccess = true

    install(HttpTimeout) {
        requestTimeoutMillis = TIMEOUT.toMillis()
    }

    install(HttpRequestRetry)

    install(Auth) {
        basic {
            credentials { BasicAuthCredentials(ONBOARDING_WORKFLOW_TOKEN, onboardingWorkflowSecret) }
            sendWithoutRequest { true }
        }
    }

    install(ContentNegotiation) {
        json(
            Json {
                ignoreUnknownKeys = true
            }
        )
    }

    defaultRequest {
        url {
            protocol = URLProtocol.HTTPS
            host = HOST
            path(Path.VERSION)
        }
    }
}

val Evaluation.idScore get() = try {
    formattedResponses["ID Analytics ID Score"]!!
        .jsonObject["data"]!!
        .jsonObject["idScore"]!!
        .jsonPrimitive.int
} catch (exception: Exception) {
    logger.warn("Unable to extract ID Score from evaluation [$token].", exception)

    null
}

val Evaluation.sigmaSyntheticFraudScore get() = try {
    rawResponses["Socure 30"]!!
        .jsonArray.first { "synthetic" in it.jsonObject }
        .jsonObject["synthetic"]!!
        .jsonObject["scores"]!!
        .jsonArray.first { it.jsonObject["name"]?.jsonPrimitive?.content == "synthetic" }
        .jsonObject["score"]!!
        .jsonPrimitive.bigDecimal
} catch (exception: Exception) {
    logger.warn("Unable to extract Sigma Synthetic Fraud Score from evaluation [$token].", exception)

    null
}

val Evaluation.vantageScore get() = try {
    formattedResponses["Experian"]!!
        .jsonObject["data"]!!
        .jsonObject["models"]!!
        .jsonObject["V4"]!!
        .jsonObject["score"]!!
        .jsonPrimitive.int
} catch (exception: Exception) {
    logger.warn("Unable to extract VantageScore from evaluation [$token].", exception)

    null
}
