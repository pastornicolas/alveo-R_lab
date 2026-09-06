library(shiny)
library(shinyjs)

source("R/recursos.R")
source("R/estructuras.R")
source("R/clave.R")
source("R/server_muestras.R")
source("R/server_clave.R")
source("R/server_estructuras.R")
source("R/server_ciclo.R")

# Definición UI ----
ui <- fluidPage(
  tags$head(
    tags$title("Alveo R Lab"),
    tags$link(
      rel = "stylesheet",
      href = "css/estilos.css"
    ),
    tags$script(
      src = "https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"
    ),
    tags$script(
      src = "js/scripts.js"
    )
  ),
  
  ## Titulo ----
  titlePanel(HTML('<span style="font-weight:bold;">Alveo R Lab</span>
                  <span style="font-style:italic;font-size: 0.7em;"> - Laboratorio virtual interactivo para el
                  estudio de organismos pertenecientes a Alveolata</span>')),
  style = "background-image: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; padding: 20px;",
  
  # Tabs principal
  tabsetPanel(
    type = "tabs",
    
    # Pestaña Muestras ----
    tabPanel(
      title = "Visualización Muestras", 
      icon = icon("image"),
      
      ### Captura de pantalla ----
      div(class = "capture-btn-container",
          actionButton("capture_screen", "Capturar Pantalla", icon = icon("camera"))
      ),
      
      div(id = "muestras-tab",class = "muestras-tab",
        
        ## 1. Ciliados ----
        div(class = "fixed-box", style = "top: 5px; left: 0px;",
            h3("Ciliophora", style = "margin-top: 0; color: #007bc2;"),
            p(style = 'font-size: 12px; font-style: italic; position: absolute; bottom: 10px; right: 10px',
              "Mueva aquí las muestras correspondientes a este grupo.")
        ),
        ## 2. Apicomplejos ----
        div(class = "fixed-box", style = "top: 5px; right: 0px; border-color: #c23700;",
            h3("Apicomplexa", style = "margin-top: 0; color: #c23700;"),
            p(style='font-size:12px; font-style: italic; position: absolute; bottom: 10px; right:10px',
              "Mueva aquí las muestras correspondientes a este grupo.")
        ),
        ### 3. Dinoflagelados ----
        div(class = "fixed-box", style = "bottom: 20px; left: 0px; border-color: #00c22d;",
            h3("Dinoflagellata", style = "margin-top: 0; color: #00c22d;"),
            p(style='font-size:12px; font-style: italic; position: absolute; bottom: 10px; right:10px',
              "Mueva aquí las muestras correspondientes a este grupo.")
        ),
        ### 4. No corresponden... ----
        div(class = "fixed-box", style = "bottom: 20px; right: 0px; border-color: #484d49;",
            h3("No pertenece a Alveolata", style = "margin-top: 0; color: #484d49;"),
            p(style='font-size:12px; font-style: italic; position: absolute; bottom: 10px; right:10px',
              "Mueva aquí las muestras que no corresponden a ninguno de estos grupos.")
        ),
        
        ### Tarjetas de MUESTRAS ----
        tagList(
          lapply(seq_along(sample_files), function(i) {
            
            absolutePanel(
              top = ptop[i], left = pleft[i], height = alto, draggable = TRUE,
              style = "z-index: 10;", p(tags$img(src = paste0("samples/", sample_files[i]),
                                                 style = paste0("height:", alto,
                                                                "px; width:auto;")
                                                 )),
              actionButton(class = "center-action-btn", inputId = paste0("open_tab_", i),
                           label = paste("Muestra", as.integer(gsub("\\D", "", sample_files[i]))),
                           icon = icon("expand",style = paste0("font-size:", ttext)),
                           # onclick = paste0("window.open('samples/", file, "', '_blank')")
                           )
              )
            
          })
        )
      )
    ),
    
    # Clave para identificacion ----
    tabPanel(
      title = "Clave dicotómica",
      icon = icon("code-branch"),
      sidebarLayout(
        sidebarPanel(
          width = 3,
          selectInput(
            "key_organism",
            "Seleccione el grupo:",
            choices = c(
              "Dinoflagellata",
              "Ciliophora"
              )
          ),
          hr(),
          uiOutput("dichotomous_key")
        ),
        
        mainPanel(
          uiOutput("key_image")
        )
      )
    ),
    # Estructuras celulares ----
    tabPanel(
      title = "Estructuras Morfológicas", 
      icon = icon("search"),
      br(),
      #h2("Guía de Estudio: Alveolata"),
      
      sidebarLayout(
        
        sidebarPanel(
          width = 2,
          
          selectInput(
            inputId = "organism",
            label = "Seleccione un organismo:",
            choices = c("Dinoflagellata - Ceratium" = "ceratium.png",
                        "Dinoflagellata - Gymnodinium" = "gymno.png",
                        "Dinoflagellata - Peridinium" = "perid.png",
                        "Dinoflagellata - Noctiluca" = "nocti.png",
                        "Ciliophora - Didinium" = "didinium.png",
                        "Ciliophora - Paramecium" = "paramec.png",
                        "Ciliophora - Strombidium" = "stromb.png",
                        "Ciliophora - Urosoma" = "urosoma.png",
                        "Ciliophora - Vorticella" = "vorticella.png"),
            selected = NA
          ),
          br(),br(),br(),
          br(),br(),br(),
          br(),br(),br(),
          br(),br(),br(),
          h4("Estructuras"),
          
          uiOutput("morphological_labels")
          
        ),
        mainPanel(
          uiOutput("selected_organism")
        )
      )
    ),
    
    # Ciclo de Plasmodium ----
    tabPanel(
      title = HTML("Ciclo de <span style='font-style: italic;'>Plasmodium</span>"), 
      icon = icon("sync"),
      
      ### Captura de pantalla ----
      div(class = "capture-btn-container",
          actionButton("capture_screen", "Capturar Pantalla", icon = icon("camera"))
      ),
      br(),
      
      ### Base del ciclo ----
      div(
        h3(style = 'margin-top: 4px !important;', "Ciclo de la infección"),
        p(style = 'font-style: italic', "Ubique en el gráfico cada tipo celular"),
        tags$img(
          src = "plasmod/plasmodium_ciclo.png",
          style = "width: 70%; height: auto;",
          class = "main-layout-image"
        )
        ),
      ### Trofo anillado ----
      absolutePanel(
        top = "250px", left = "50px", height = alto, width = "400px",
        draggable = TRUE, style = "z-index: 10;",
        fluidRow(style = "display: flex; align-items: center; margin: 0;",
                 column(width = 3, style = "display: flex; justify-content: center; padding: 0 5px; margin-right: 35px;",
                        actionButton(class = 'center-action-btn', "open_trof", HTML("Trofozoito<br>Anillado"))),
                 column(width = 3, style = "display: flex; justify-content: center; padding: 0 5px;",
                        tags$img(src = "plasmod/trofo.png", style = paste0("height:", alto+50, "px; width:auto;"))))
        ),
      ### Gametocitos ----
      absolutePanel(
        top = "450px", left = "50px", height = alto+50, width = "400px",
        draggable = TRUE, style = "z-index: 10;",
        fluidRow(style = "display: flex; align-items: center; margin: 0;",
                 column(width = 3, style = "display: flex; justify-content: center; padding: 0 5px;",
                        tags$img(src = "plasmod/game.png", style = paste0("height:", alto+50, "px; width:auto;"))
                 ),
                 column(width = 4, style = "display: flex; justify-content: center; padding: 0 5px; margin-left: 35px;",
                        actionButton(class = 'center-action-btn', "open_gam", "Gametocitos")))
        ),
      ### Esquizonte ----
      absolutePanel(
        top = "650px", left = "0px", height = alto, width = "400px",
        draggable = TRUE, style = "z-index: 10;",
        div(
          style = "text-align: center;",
          actionButton(class = 'center-action-btn', "open_esq", "Esquizonte",
                       style = "width: auto; display: inline-flex;margin-bottom: 10px;"),
          p(tags$img(src = "plasmod/schiz.png", style = paste0("height:", alto+50, "px; width:auto;")))
          ),
      )
      )
  ))


# Definición de servidores ----
server <- function(input, output, session) {

  server_muestras(input, output, session)
  server_clave(input, output, session)
  server_estructuras(input, output, session)
  server_ciclo(input, output, session)
  
}

shinyApp(ui, server)