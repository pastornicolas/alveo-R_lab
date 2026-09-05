# server_visual.R
# Servidor para la pestaña de Muestras

server_muestras <- function(input, output, session) {
  
  lapply(seq_along(sample_files), function(i) {
    
    observeEvent(input[[paste0("open_tab_", i)]], {
      
      showModal(modalDialog(
        tags$style(
          HTML(".modal-header .btn-close { display: none !important; }")
        ),
        title = paste("Muestra", as.integer(gsub("\\D", "", sample_files[i]))),
        div(
          style = "max-height: 80vh; overflow: auto; text-align: center;",
          tags$img(src = paste0("samples/", sample_files[i]),
                   style = "width: 100%; height: auto;")),
        easyClose = TRUE, 
        footer = modalButton(label = "Cerrar"), size = "l"
      )
      )
    }
    )
  }
  )
}