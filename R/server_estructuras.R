# server_estructuras.R
# Definición del servidor para las Estructuras morfológicas.


server_estructuras <- function(input, output, session) {

  # Estructuras ----
  output$selected_organism <- renderUI({
    
    req(input$organism)
    
    tags$img(
      src = paste0("estruct/", input$organism),
      style = "max-width: 100%; height: auto;"
    )
    
  })
  
  output$morphological_labels <- renderUI({
    
    req(input$organism)
    
    structures <- morphology[[input$organism]]
    
    tagList(
      lapply(seq_along(structures), function(i) {
        
        div(
          id = paste0("structure_", i),
          class = "morph-label",
          structures[i]
        )
        
      })
    )
  })
  
}