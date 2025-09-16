package me.msella.bingetube.screen

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger

private enum class SearchState {
    None,
    Searching,
    Success,
    Failed
}

class SearchScreen : Screen {

    val logger = Logger.withTag("MainScreen")

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        Column(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            var searchText = remember { mutableStateOf("") }
            var searchState: SearchState by remember { mutableStateOf(SearchState.None) }

            Spacer(Modifier.height(40.dp))
            TextField(
                value = searchText.value,
                onValueChange = { searchText.value = it },
                placeholder = { Text("Search Videos") },
                singleLine = true,
                keyboardOptions = KeyboardOptions.Default.copy(imeAction = ImeAction.Search),
                trailingIcon = {
                    if (searchText.value.isNotBlank()) {
                        IconButton(onClick = { searchText.value = "" }) {
                            Text("X")
                        }
                    }
                },
                keyboardActions = KeyboardActions(
                    onSearch = {

                    }
                ),
            )


        }
    }

}
