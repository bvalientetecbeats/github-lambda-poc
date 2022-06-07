package com.levelgoals.alloyevaluation.services

import software.amazon.awssdk.services.ssm.SsmClient

enum class ParameterStoreParam(val paramName: String) {
    alloyOnboardingWorkflowSecret("alloy-onboarding-workflow-secret"),
    bbdbPassword("bbdb-password")
}

private val client = SsmClient.create()

fun getParam(param: ParameterStoreParam) = client.getParameter {
    it.name(param.paramName)
    it.withDecryption(true)
}.parameter().value()!!
