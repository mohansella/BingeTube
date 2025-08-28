package me.msella.chronotube.api

import co.touchlab.kermit.Logger
import kotlinx.coroutines.delay
import kotlin.random.Random

typealias ApiKeyValidationCallback = (isSuccess: Boolean, errorMessage: String) -> Unit

class YoutubeAPI {
    companion object {
        val logger = Logger.withTag("YoutubeAPI")

        suspend fun validateApiKey(apiKey: String, callback: ApiKeyValidationCallback) {
            logger.i("checking Youtube API key")
            delay(3000)
            if(Random.nextBoolean()) {
                logger.i("validation success")
                callback(true, "")
            } else {
                logger.i("validation failed")
                callback(false, "Error: validation failed")
            }
        }
    }
}