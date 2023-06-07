
box::use(
  shiny[...],
  dplyr,
  pokemon
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = ns("pokemon"),
          label = "Selecione um pokemon",
          choices = unique(pokemon::pokemon_ptbr$pokemon)
        )
      ),
      mainPanel(
        uiOutput(ns("imagem"))
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$imagem <- renderUI({
      url <- pokemon::pokemon_ptbr |>
        dplyr::filter(pokemon == input$pokemon) |>
        dplyr::pull(url_imagem)

      img(src = url, width = "100%")
    })

  })
}
