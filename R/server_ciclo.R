# server_ciclo.R
# Servidor para la pestaña de Ciclo de Plasmodium

server_ciclo <- function(input, output, session) {
  
  observeEvent(input[['open_esq']], {
    showModal(modalDialog(
      tags$style(
        HTML(".modal-header .btn-close { display: none !important; }")),
      title = "Esquizonte",
      div(
        style = "max-height: 80vh; overflow: auto; text-align: center;",
        tags$img(src = "samples/sample9.jpg",
                 style = "width: 100%; height: auto;")),
      easyClose = TRUE, footer = modalButton(label = "Cerrar"), size = "l"
    )
    )
  }
  )
  
  observeEvent(input[['open_gam']], {
    showModal(modalDialog(
      tags$style(HTML(".modal-header .btn-close { display: none !important; }")),
      title = "Gametocitos",
      div(
        style = "max-height: 80vh; overflow: auto; text-align: center;",
        tags$img(src = "samples/sample28.jpg",
                 style = "width: 100%; height: auto;")),
      easyClose = TRUE, 
      footer = modalButton(label = "Cerrar"), size = "l"
    )
    )
  }
  )
  
  observeEvent(input[['open_trof']], {
    showModal(modalDialog(
      tags$style(HTML(".modal-header .btn-close { display: none !important; }")),
      title = "Trofozoito Anillado",
      div(
        style = "max-height: 80vh; overflow: auto; text-align: center;",
        tags$img(src = "samples/sample18.jpg",
                 style = "width: 100%; height: auto;")),
      easyClose = TRUE, 
      footer = modalButton(label = "Cerrar"), size = "l"
    )
    )
  }
  )
  
}