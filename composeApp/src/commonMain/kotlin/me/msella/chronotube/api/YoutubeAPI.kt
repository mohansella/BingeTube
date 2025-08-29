package me.msella.chronotube.api

import co.touchlab.kermit.Logger
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

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
                val response = client.get("https://www.googleapis.com/youtube/v3/channels") {
                    parameter("part", "snippet")
                    parameter("forUsername", "Youtube")
                    parameter("key", apiKey)
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
                    callback(false, "$errMessage Status:${response.status.value}")
                }
            } catch (e: Exception) {
                //failed: network or system error
                logger.e(e) { "Error checking Youtube API key" }
                callback(false, "Error: ${e.message ?: e.toString()}")
            }
        }
    }
}