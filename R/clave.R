## clave.R ----
# Clave dicotómica para separar organismos de Alveolata

keys <- list(
  
# Dinoflagellata ----
Dinoflagellata = list(title = "Dinoflagellata",
                        
        "1" = list(
          option1 = "Células desnudas.",
          next1 = "2",
          option2 = "Células con placas.",
          next2 = "3"
          ),
        
        "2" = list(
          option1 = "Células sin surco transverso. Exclusivamente marinas.",
          next1 = "Noctiluca",
          option2 = "Células con surco transverso bien desarrollado.",
          next2 = "Gymnodinium"
          ),
        
        "3" = list(
          option1 = "Células provistas de prolongaciones (le dan al individuo
          un aspecto de ancla).",
          next1 = "Ceratium",
          option2 = "Células sin prolongaciones.",
          next2 = "Peridinium"
          )
        ),
  
# Ciliophora ----
  
Ciliophora = list(
  title = "Ciliophora",
  
        "1" = list(
          option1 = "Organismos de vida libre.",
          next1 = "2",
          option2 = "Organismos fijos con pie.",
          next2 = "Vorticella"
          ),
       
        "2" = list(
          option1 = "Zona posterior de la célula no ciliada uniformemente ni
          con hilera de cilios, sólo con un cilio caudal largo.",
          next1 = "Urotrichia",
          option2 = "Zona posterior de la célula ciliada uniformemente o con una hilera de cilios.",
          next2 = "3"
          ),
  
        "3" = list(
          option1 = "Boca hundida en una ranura oral central.",
          next1 = "4",
          option2 = "Boca no hundida en una ranura oral central.",
          next2 = "6"
          ),
    
        "4" = list(
          option1 = "Con hileras de cirros en diferentes áreas de la célula.",
          next1 = "5",
          option2 = "Sin hileras de cirros.",
          next2 = "Paramecium"
          ),
      
        "5" = list(
          option1 = "Zona posterior de la célula en forma de extremidad aguzada.",
          next1 = "Urosoma",
          option2 = "Zona posterior de la célula redondeada.",
          next2 = "Oxytrichia"
          ),
    
        "6" = list(
          option1 = "Cilios dispuestos en hileras en zona posterior a la boca.",
          next1 = "Didinium",
          option2 = "Cilios dispuestos en hileras alrededor de la boca.",
          next2 = "Strombidium"
          )
  )
)

# Mapeo de fotos ----

genus_samples <- list(
  # Dinoflagellata
  Ceratium = c(
    "sample5.jpg",
    "sample11.png",
    "sample29.jpg"
  ),
  Gymnodinium = c(
    "sample14.jpeg",
    "sample30.jpeg"
  ),
  Noctiluca = c(
    "sample3.jpeg",
    "sample8.jpeg",
    "sample23.jpeg"
  ),
  Peridinium = c(
    "sample1.png",
    "sample24.jpg"
  ),
  # Ciliophora
  Vorticella = c(
    "sample12.png",
    "sample16.jpeg",
    "sample26.png"
  ),
  Urotrichia = c(
    "sample21.png"
  ),
  Paramecium = c(
    "sample2.png",
    "sample13.png"
  ),
  Urosoma = c(
    "sample19.jpg"
  ),
  Oxytrichia = c(
    "sample27.jpg"
  ),
  Didinium = c(
    "sample22.jpeg"
  ),
  Strombidium = c(
    "sample17.jpg"
  )
)
