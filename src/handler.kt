package com.levelgoals.alloyevaluation

import com.levelgoals.alloyevaluation.services.Evaluation
import com.levelgoals.alloyevaluation.services.bbdbTransaction
import com.levelgoals.alloyevaluation.services.getSsnItem
import com.levelgoals.alloyevaluation.services.idScore
import com.levelgoals.alloyevaluation.services.runOnboardingEvaluation
import com.levelgoals.alloyevaluation.services.sigmaSyntheticFraudScore
import com.levelgoals.alloyevaluation.services.vantageScore
import com.levelgoals.alloyevaluation.utils.logger
import com.levelgoals.bigbangdb.daos.Address
import com.levelgoals.bigbangdb.daos.AlloyEvaluation
import com.levelgoals.bigbangdb.daos.AlloyEvaluation.Outcome
import com.levelgoals.bigbangdb.daos.Application
import com.levelgoals.bigbangdb.daos.User
import kotlinx.coroutines.runBlocking
import java.util.UUID

data class Request(
    var applicationId: UUID? = null,
    var fullyFlowOfFunds: Boolean? = null
)

data class Response(
    val token: String,
    val outcome: Outcome
)

@Suppress("unused")
fun handle(request: Request): Response {
    val evaluation = bbdbTransaction {
        val application = Application.get(request.applicationId!!)
        val user = application.user
        val address = user.newestPersonalAddress!!
        val ssn = getSsnItem(user.id.value)!!.ssn!!
        val userMetadatum = user.newestMetadatum!!
        val decisionOnCredit = !request.fullyFlowOfFunds!!

        val evaluationResponse = runBlocking {
            runOnboardingEvaluation(application, user, address, ssn, userMetadatum, decisionOnCredit)
        }

        user.alloyEntityToken = evaluationResponse.entityToken
        user.flush() // A transaction error occurs without this

        if (evaluationResponse.outcome == Outcome.denied || evaluationResponse.outcome == Outcome.manualReview) {
            application.status = Application.Status.needsAttention
        }

        return@bbdbTransaction insertEvaluation(evaluationResponse, application)
    }

    logger.info("Evaluation [${evaluation.id.value}] run with outcome [${evaluation.outcome}].")

    return Response(evaluation.id.value, evaluation.outcome)
}

private fun insertEvaluation(response: Evaluation, application: Application) = AlloyEvaluation.new(response.token) {
    applicationId = application.id
    userId = application.userId
    runTimestamp = response.timestamp
    outcome = response.outcome
    idScore = response.idScore
    sigmaSyntheticFraudScore = response.sigmaSyntheticFraudScore
    vantagescore = response.vantageScore
}

private val User.newestMetadatum get() = metadata.maxByOrNull { it.createdTimestamp }

private val User.newestPersonalAddress get() = addresses
    .filter { it.type == Address.Type.personal }
    .maxByOrNull { it.createdTimestamp }
