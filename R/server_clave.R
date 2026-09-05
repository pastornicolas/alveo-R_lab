# server_clave.R
# Definición del servidor para las claves dicotómicas.


server_clave <- function(input, output, session) {

    # Posición actual
    current_step <- reactiveVal("1")
    
    # Historial de pasos
    step_history <- reactiveVal(character(0))
    
    # Resetear si cambio el grupo seleccionado)
    observeEvent(input$key_organism, {
      
      current_step("1")
      step_history(character(0))
      })
    
    # Mostrar paso "actual"
    output$dichotomous_key <- renderUI({
      
      req(input$key_organism)
      
      key <- keys[[input$key_organism]]
      step <- current_step()
      
      # Identificación positiva
      if (!step %in% names(key)) {
        
        return(
          tagList(
            div(class = "identification-result",
                h4("Identificación"),
                h2(HTML(paste0("<i>", step, "</i> sp.")))
                ),
            br(),
            actionButton(
              "key_back",
              "↩ Volver",
              class = "btn btn-secondary"
              )
            )
        )
      }
      
      # Dilema actual
      tagList(
        h4(paste("Dilema", step),
           style = "text-align: center;"),
        br(),
        div(class = "key-options",
            
            actionButton(class = "key-option",
                         "key_option1",
                         label = key[[step]]$option1),
            actionButton(class = "key-option",
                         "key_option2",
                         label = key[[step]]$option2)
            ),
        br(),
            
            actionButton(class = "btn btn-secondary",
                         "key_back",
                         "↩ Volver")
        )
      })
  
  
  # Dilema Op. 1
  observeEvent(input$key_option1, {
    
    req(input$key_organism)
    
    key <- keys[[input$key_organism]]
    step <- current_step()
    
    next_step <- key[[step]]$next1
    
    # Al historial...
    step_history(
      c(step_history(), step)
    )
    # Ir a dilema siguiente
    current_step(next_step)
    
  })
  
  
  # Dilema Op. 2
  
  observeEvent(input$key_option2, {
    
    req(input$key_organism)
    
    key <- keys[[input$key_organism]]
    step <- current_step()
    
    next_step <- key[[step]]$next2
    
    # Al historial...
    step_history(
      c(step_history(), step)
    )
    # Ir a dilema siguiente
    current_step(next_step)
    
  })
  
  # Volver
  
  observeEvent(input$key_back, {
    
    history <- step_history()
    
    if (length(history) == 0) {
      return()
    }
    
    # Ultimo dilema
    previous_step <- tail(history, 1)
    
    
    # Si vuelve, borrarlo
    step_history(
      head(history, -1)
    )
    
    # Volver a dilema anterior.
    current_step(previous_step)
  })
  
  #### IMAGENES -----
  output$key_image <- renderUI({
    
    req(input$key_organism)
    
    key <- keys[[input$key_organism]]
    step <- current_step()
    
    # Organismos posibles según el paso
    if (input$key_organism == "Dinoflagellata") {
      
      possible <- switch(
        step,
        "1" = c("Noctiluca", "Gymnodinium", "Ceratium", "Peridinium"),
        "2" = c("Noctiluca", "Gymnodinium"),
        "3" = c("Ceratium", "Peridinium"),
        step
      )
      
    } else {
      possible <- switch(
        step,
        "1" = c(
          "Vorticella", "Urotrichia", "Paramecium",
          "Urosoma", "Oxytrichia", "Didinium", "Strombidium"
        ),
        "2" = c(
          "Urotrichia", "Paramecium", "Urosoma",
          "Oxytrichia", "Didinium", "Strombidium"
        ),
        "3" = c(
          "Paramecium", "Urosoma", "Oxytrichia",
          "Didinium", "Strombidium"
        ),
        "4" = c(
          "Paramecium", "Urosoma", "Oxytrichia"
        ),
        "5" = c(
          "Urosoma", "Oxytrichia"
        ),
        "6" = c(
          "Didinium", "Strombidium"
        ),
        step
      )
    }
    
    selected_samples <- lapply(possible, function(genus) {
      genus_samples[[genus]]
    })
    
    # Obtener las muestras correspondientes a cada género posible
    div(
      style = "width: 100%;padding: 10px;",
      
      h3(input$key_organism,
      style = "text-align: center;margin-bottom: 20px;"
      ),
      
      div(style = "display: flex; flex-wrap: wrap; justify-content: center;
      align-items: flex-start; gap: 30px;",
        
        lapply(possible, function(genus) {
          
          samples <- genus_samples[[genus]]
          
          # Contenedor para cada género
          div(
            style = "
              text-align: center;
              width: 280px;
            ",
            div(
              style = "
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                column-gap: 0px;
                row-gap: 10px;
              ",
              
              lapply(seq_along(samples), function(j) {
                
                sample <- samples[j]
                
                # ID único para cada imagen
                img_id <- paste0(
                  "key_sample_",
                  gsub("[^A-Za-z0-9]", "_", genus),
                  "_",
                  j
                )
                actionLink(
                  inputId = img_id,
                  tags$img(src = paste0("samples/", sample),
                  style = "max-width: 280px;
                           max-height: 280px;
                           width: auto;
                           height: auto;
                           object-fit: contain;
                           cursor: pointer;"
                  )
                  )
                })
              )
            )
          })
        )
      )
  })
  

  
  lapply(names(genus_samples), function(genus) {

    samples <- genus_samples[[genus]]
    
    lapply(seq_along(samples), function(j) {
      
      sample <- samples[j]
      
      img_id <- paste0(
        "key_sample_", gsub("[^A-Za-z0-9]", "_", genus), "_", j)
      
      observeEvent(
        input[[img_id]],
        {
          showModal(
            modalDialog(
              tags$style(HTML("
                  .modal-header .btn-close {display: none !important;}
                              ")),
              title = "",
              div(
                style = "max-height: 80vh;
                         overflow: auto; 
                         text-align: center;",
                tags$img(src = paste0("samples/", sample),
                         style = "width: 100%; height: auto;"
                         )),
              easyClose = TRUE,
              footer = modalButton(label = "Cerrar"), size = "l"
              ))
          }, ignoreInit = TRUE
        )
      })
    })
  
  
}