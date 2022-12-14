addResourcePath(prefix = "www", directoryPath = "www/")
# UI ----
library(shiny)

app_ui <- shiny::div(shinyFeedback::useShinyFeedback(),
          shinyjs::useShinyjs(),
          # tags$head(
          #   tags$link(rel = "stylesheet", type = "text/css", href = "maqueta.css")
          # ),
          shiny::includeCSS("www/maqueta.css"),

          shiny::div(class="top-ine",
              shiny::fluidPage(
                shiny::div(class="container",
                    shiny::HTML('<div class="menu-ine">
                <img class="logo-ine" src="www/ine_blanco.svg" alt="INE">
            </div>
            <div class="pull-right">
                <a class="btn btn-xs btn-primary" href="https://www.ine.cl" target="_blank">Volver al home INE</a>
            </div>'),
                )
              )
          ),
          shiny::div(class="conten-ine",

              ### fluid page de texto de descripción
              shiny::fluidPage(
                #   shiny::div(class="container-fluid",
                shiny::div(class="container",
                    shiny::HTML('<div class="row">
                <div class="col-md-12">
                    <h4 class="titu-ine">Evaluación de Calidad de Estimaciones en Encuestas de Hogares</h4>
                    <p class="text-ine">
Esta aplicación permite acercar a las personas usuarias la implementación del estándar de calidad para la evaluación de estimaciones en encuestas de hogares del INE. A través de ella, las personas usuarias pueden conocer la precisión que tienen las estimaciones generadas a partir de encuestas producidas por el INE u otras encuestas que utilicen muestreo probabilístico estratificado y en 2 etapas. Con esto se busca poner a disposición de la comunidad una herramienta interactiva para la cual no se requiere contar con conocimientos de programación, promoviendo el uso adecuado de la información publicada. Esta aplicación permite evaluar la calidad de la estimación de medias, totales y proporciones.                    </p>
                </div>
            </div>')
                )
              )
          ),
          # Agregar el logo del INE

          shiny::div(class="dash-ine",
              shiny::fluidPage(
                waiter::useWaitress("white"),
                shiny::div(class="container",
                    sidebarLayout(
                      ## Sidebar ####
                      sidebarPanel(width = 3,
                                   ## UI INPUT ####
                                   shinyWidgets::radioGroupButtons(
                                     inputId = "Id004",
                                     label = h4("Selecciona desde donde cargar base de datos"),
                                     choices = c("Cargar datos propios", "Trabajar con datos INE"),
                                     status = "primary",
                                     justified = TRUE
                                   ),
                                   h5("En esta Sección puedes seleccionar la opción de cargar una base de datos desde tu computador, o cargar una base de datos del INE"),
                                   uiOutput("datos_locales"),
                                   uiOutput("DescargaINE"),
                                   #### Edición datos
                                   #checkboxInput("data_edit", "¿Desea editar sus datos?",value = F),
                                   shinyWidgets::radioGroupButtons(
                                     inputId = "SCHEME",
                                     label = h5("Selecciona el esquema de evaluación, INE o CEPAL"),
                                     choices = c("chile", "cepal"),
                                     status = "primary",
                                     justified = TRUE
                                   ),
                                   ## render selección de variables de interes, y de cruce
                                   # uiOutput("seleccion1"),
                                   selectInput("varINTERES", label = h5("Variable de interés"),choices = "",  multiple = F),
                                   #textOutput("wrn_var_int"),

                                   uiOutput("denominador"),

                                   radioButtons("tipoCALCULO", "¿Qué tipo de cálculo deseas realizar?",
                                                choices = list("Media","Proporción","Suma variable Continua","Conteo casos"), inline = F ),
                                   selectInput("varCRUCE", label = h5("Desagregación"), choices = "", selected = NULL, multiple = T),
                                   checkboxInput("IC", "¿Deseas agregar intervalos de confianza?",value = F),
                                   #checkboxInput("ajuste_ene", "¿Deseas agregar los ajuste del MM ENE?",value = F),
                                   uiOutput("etiqueta"),
                                   selectInput("varSUBPOB", label = h5("Subpoblación"), choices = "", selected = NULL, multiple = F),
                                   selectInput("varFACT1", label = h5("Variable para factor de expansión"), choices = "",selected ="", multiple = F),
                                   selectInput("varCONGLOM", label = h5("Variable para conglomerados"), choices = "", selected = "", multiple = F),
                                   selectInput("varESTRATOS",label = h5("Variable para estratos"), choices = "", selected = "", multiple = F),
                                   shinyjs::disabled(downloadButton("tabla", label = "Descargar tabulado")),
                                   actionButton("actionTAB", label = "Generar tabulado"),
                                   ## render selección variables DC
                                   uiOutput("seleccion2"),
                                   ## botón generación tabulado
                                   uiOutput("botonTAB")

                      ),
                      ## Main PANEL ----
                      mainPanel(width = 9,
                                #### render titulo tabulado
                                uiOutput("tituloTAB"),
                                uiOutput("edicion_datos")

                      )
                    )
                )
              )
          ),
          shiny::div(class="footer",
              shiny::fluidPage(
                shiny::div(class="container",
                    shiny::HTML('<div class="row">
                <div class="col-md-4">
                    <h4>INE en redes sociales</h4>
                    <a href="https://www.facebook.com/ChileINE/" target="_blank"><img class="facebook" src="www/facebook.svg"></a>
                    <a href="https://twitter.com/ine_chile?lang=es" target="_blank"><img class="twitter" src="www/twitter.svg"></a>
                    <a href="https://www.youtube.com/user/inechile" target="_blank"><img class="youtube" src="www/youtube.svg"></a>
                    <a href="https://www.instagram.com/chile.ine/" target="_blank"><img class="instagram" src="www/instagram.svg"></a>
                    <h4>Consultas</h4>
                    <p><a href="https://www.portaltransparencia.cl/PortalPdT/ingreso-sai-v2?idOrg=1003" target="_blank">Solicitud de acceso a la información pública</a></p>
                    <p><a href="https://atencionciudadana.ine.cl/" target="_blank">Atención ciudadana</a></p>
                </div>
                <div class="col-md-4">
                    <h4>Contacto</h4>
                    <p>
                        Dirección nacional: Morandé N°801, piso 22, Santiago, Chile<br>
                        RUT: 60.703.000-6<br>
                        Código postal: 8340148<br>
                    </p>
                </div>
                <div class="col-md-4">
                    <h4>SIAC / OIRS</h4>
                    <p>
                        Horario de atención:<br>
                        Lunes a viernes 9:00 a 17:00 horas<br>
                        Fono : <a>232461010</a> - <a>232461018</a><br>
                        Correo: ine@ine.cl<br>
                    </p>
                </div>
            </div>')
                )
              )
          ),
          shiny::div(class="pie-ine",
              shiny::fluidPage(
                shiny::div(class="container",
                    shiny::HTML('
        <div class="text-right">
            Instituto Nacional de Estadísticas
       </div>')
                )
              )
          )
)

          ###### render UI origen de datos #####

renderUI_origen_datos <- function(req){

  if(req == "Trabajar con datos INE"){

    tagList(
      ## input archivo página del INE
      selectInput("base_web_ine", label = h4("Utilizar una base de datos del INE"),
                  choices = nom_arch_ine,
                  multiple = F),

      actionButton("base_ine", label = "Cargar base desde el INE"),

    )

  }else if(req == "Cargar datos propios"){

    tagList(
      ## input de archivo local -----
      fileInput(inputId = "file", label = h4("Carga una base de datos desde tu computador"),buttonLabel = "Buscar" , placeholder = ".sav .rds .dta .sas .xlsx .csv .feather")
    )

  }
}


### modal definicion indicadores ####

modal_indicadores <- function(){
showModal(modalDialog(
  title = "Definición de indicadores",

  HTML("

<h5><strong>stat:</strong> Estimación variable de interés</h5>

<strong><h4>Insumos a evaluar:</h4></strong>

<h5><strong>Estandar INE Chile</strong></h5>

<h5><strong>es:</strong> Error Estandar.        <br>
<strong>cv:</strong> Coeficiente de Variación.       <br>
<strong>df:</strong> Grados de Libertad.        <br>
<strong>n:</strong> Casos muestrales.     </h5>     <br>

<h5><strong>Estandar CEPAL</strong></h5>

<h5><strong>deff:</strong> Efecto diseño <br>
<strong>ess:</strong> Tamaño de muestra efectiva <br>
<strong>unweighted:</strong> Conteo no ponderado </h5> <br>

<strong><h4>Resultados de la evaluación: </h4></strong>   \n

<h5><strong>Estandar INE Chile</strong></h5>

<h5><strong>eval_n:</strong> Evaluación de casos muestrales        <br>
<strong>eval_df:</strong> Evaluación de grados de libertad.        <br>
<strong>eval_cv:</strong> Evaluación del Coeficiente de variación.        <br>
<strong>calidad:</strong> Evaluación final de la celda, puede ser: <p style=\"font-style: italic;\"> Fiable, Poco Fiable o No fiable </p> </h5><br>

<h5><strong>Estandar CEPAL</strong></h5>

<h5><strong>eval_n:</strong> Evaluación de casos muestrales <br>
<strong>eval_ess:</strong> Evaluación tamaño de muestra efectivo <br>
<strong>eval_df:</strong> Evaluación grados de libertad <br>
<strong>eval_cv:</strong> Evaluación del Coeficiente de variación. <br>
<strong>calidad:</strong> Evaluación final de la celda, puede ser: <p style=\"font-style: italic;\"> Publicar, Revisar o Suprimir </p> </h5>"
  ), easyClose = T, footer = actionButton(inputId = "cerrar_modal", "Cerrar"),
))
}


#  ess  Effective sample size
#  rm.na  Remove NA if it is required
#  deff  Design effect
#  rel_error  Relative error
#  unweighted  Add non weighted count if it is required "

### render UI main panel ####


renderUI_main_panel <- function(){

tagList(
  div(id="panel_central",class="titu-ine",
      h2("Resultado evaluación de calidad"),
  actionButton("show", "Definición de indicadores"),uiOutput("PRUEBAS2"),
  ### render gráfico de resumen
  div(style='width:100%;overflow-x: scroll;',
      div(plotOutput('grafico'),
          align = "center",
          style = "height:200px"),
      ### render tabulado
      tags$div(
        class="my_table", # set to custom class
        htmlOutput("tabulado") %>% shinycssloaders::withSpinner(color="white"))
  ))
)

}






