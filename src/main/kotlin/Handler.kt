package com.levelgoals.unittest


import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestHandler
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent

@Suppress("unused")
class Handler : RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {
    override fun handleRequest(event: APIGatewayProxyRequestEvent, context: Context): APIGatewayProxyResponseEvent {
        val userId = "007"
        return buildSuccessResponse("success $userId")
    }
}

private fun buildSuccessResponse(createAccountUrl: String) = APIGatewayProxyResponseEvent().apply {
    statusCode = 200
    body =createAccountUrl
}
