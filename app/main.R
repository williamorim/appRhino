box::use(
  shiny[navbarPage, moduleServer, NS, tabPanel],
)

box::use(
  app/view/imagem_pokemon,
  app/view/visao_por_tipo,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  navbarPage(
    title = "Pokemon",
    tabPanel(
      title = "Qual é esse pokemon?",
      imagem_pokemon$ui(ns("imagem_pokemon"))
    ),
    tabPanel(
      title = "Visão por tipo",
      visao_por_tipo$ui(ns("visao_por_tipo"))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    imagem_pokemon$server("imagem_pokemon")
    visao_por_tipo$server("visao_por_tipo")
  })
}
