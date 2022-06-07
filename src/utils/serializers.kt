package com.levelgoals.alloyevaluation.utils

import com.levelgoals.bigbangdb.daos.AlloyEvaluation
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import java.time.Instant

object EpochMillisecondsSerializer : KSerializer<Instant> {
    override val descriptor = PrimitiveSerialDescriptor(Instant::class.simpleName!!, PrimitiveKind.LONG)

    override fun deserialize(decoder: Decoder) = Instant.ofEpochMilli(decoder.decodeLong())!!

    override fun serialize(encoder: Encoder, value: Instant) = encoder.encodeLong(value.toEpochMilli())
}

object EvaluationOutcomeSerializer : KSerializer<AlloyEvaluation.Outcome> {
    override val descriptor = PrimitiveSerialDescriptor(AlloyEvaluation.Outcome::class.simpleName!!, PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder) = when (val outcome = decoder.decodeString()) {
        "Approved" -> AlloyEvaluation.Outcome.approved
        "Denied" -> AlloyEvaluation.Outcome.denied
        "Manual Review" -> AlloyEvaluation.Outcome.manualReview
        else -> throw IllegalStateException("Unknown outcome [$outcome].")
    }

    // Not currently needed
    override fun serialize(encoder: Encoder, value: AlloyEvaluation.Outcome) = throw UnsupportedOperationException()
}
