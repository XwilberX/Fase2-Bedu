
datos<-read.csv("D:/BEDU/Fase 2/Clase 8/appRBueno/match.data.csv", header=T)
shinyServer(function(input, output) {
    
        
    output$distPlot <- renderPlot(

            ggplot(data=datos[datos$home.team==input$x,],aes(x=home.score, y= away.score) )+geom_bar(stat = "identity")+
                facet_wrap(~away.team)
        )
    output$datatable <- renderDataTable({data=datos[datos$home.team==input$x,]})
    
})
