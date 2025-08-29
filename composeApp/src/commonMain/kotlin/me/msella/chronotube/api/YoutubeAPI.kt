package me.msella.chronotube.api

import co.touchlab.kermit.Logger
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import io.ktor.http.isSuccess
import io.ktor.http.parameters
import io.ktor.serialization.kotlinx.json.json
import kotlinx.coroutines.delay
import kotlinx.serialization.json.Json
import kotlin.random.Random
import kotlinx.serialization.Serializable

private typealias ApiKeyValidationCallback = (isSuccess: Boolean, errorMessage: String) -> Unit

@Serializable
data class YouTubeErrorResponse(val error: ErrorDetail) {
    @Serializable
    data class ErrorDetail(val code: Int, val message: String)
}

class YoutubeAPI {
    companion object {
        val logger = Logger.withTag("YoutubeAPI")

        val client = HttpClient() {
            install(ContentNegotiation) {
                json(Json {
                    ignoreUnknownKeys = true
                })
            }
        }

        suspend fun validateApiKey(apiKey: String, callback: ApiKeyValidationCallback) {
            logger.i("checking Youtube API key")
            try {
                val response = client.get("https://www.googleapis.com/youtube/v3/videos") {
                    url {
                        parameters {
                            append("part", "snippet")
                            append("forUsername", "youtube")
                            append("format", "json")
                            append("key", apiKey)
                        }
                    }
                }
                if (response.status.isSuccess()) {
                    //success
                    logger.i { "Successfully validated Youtube API key" }
                    callback(true, "")
                } else {
                    //failed: show error message from response
                    logger.w { "Failed to validate Youtube API key" }
                    val errMessage = try {
                        response.body<YouTubeErrorResponse>().error.message
                    } catch (e: Exception) {
                        "Unknown error: ${e.message}"
                    }
                    callback(false, "StatusCode: ${response.status.value} Message:${errMessage}")
                }
            } catch (e: Exception) {
                //failed: network or system error
                logger.e(e) { "Error checking Youtube API key" }
                callback(false, "Error: ${e.message ?: e.toString()}")
            }
        }
    }
}