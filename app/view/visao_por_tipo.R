
box::use(
  shiny[...],
  dplyr,
  pokemon,
  ggplot2,
  tidyr
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = ns("tipo"),
          label = "Selecione um tipo",
          choices = unique(pokemon::pokemon_ptbr$tipo_1)
        )
      ),
      mainPanel(
        plotOutput(ns("grafico"))
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$grafico <- renderPlot({

      pokemon::pokemon_ptbr |>
        dplyr::filter(
          tipo_1 == input$tipo |
            tipo_2 == input$tipo
        ) |>
        dplyr::select(
          id,
          ataque:velocidade
        ) |>
        tidyr::pivot_longer(
          cols = ataque:velocidade,
          names_to = "stats",
          values_to = "valor"
        ) |>
        ggplot2::ggplot() +
        ggplot2::geom_boxplot(
          ggplot2::aes(x = stats, y = valor)
        )

    })

  })
}
