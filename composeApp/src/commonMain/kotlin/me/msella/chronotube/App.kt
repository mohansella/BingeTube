package me.msella.chronotube

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.safeContentPadding
import androidx.compose.material3.Button
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import org.jetbrains.compose.resources.painterResource
import org.jetbrains.compose.ui.tooling.preview.Preview

import chronotube.composeapp.generated.resources.Res
import chronotube.composeapp.generated.resources.compose_multiplatform

@Composable
@Preview
fun App() {
    val apiKey = remember {mutableStateOf("")}
    MaterialTheme {
        if(apiKey.value == "") {
            EnterApiScreen(onSave = { key: String -> apiKey.value = key })
        } else {
            Text("api key:${apiKey.value}")
        }
    }
}

@Composable
@Preview
fun EnterApiScreen(onSave: (String) -> Unit = {})  {
    val textValue = remember { mutableStateOf("")}
    Column(
        modifier = Modifier.fillMaxSize()
            .background(color = MaterialTheme.colorScheme.background),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        TextField(
            value = textValue.value,
            onValueChange = { value -> textValue.value = value },
            label = { Text("Enter API Key: ${textValue.value}") },
        )
        Spacer(Modifier.height(16.dp))
        Button(onClick = { onSave(textValue.value) }) {
            Text("Save")
        }
    }
}


/**/