library(shiny)
library(leaflet)
library(leaflet.extras)
library(magrittr)
library(rgdal)
library(sp)
library(raster)

shinyServer(function(input, output, session) {
  showModal(modalDialog(title="LOADING TEPHRA DB - PLEASE WAIT...","Please wait for a map to draw before proceeding.",size="l",footer=NULL))
  
  output$tephraDB <- renderTable({
    read.csv("data/No_and_age_list_fin.csv",header=TRUE, sep=",", check.names=F)
  })
  
  output$readMe <- renderTable({
    read.table("data/README.txt", header=TRUE ,sep="\n", check.names=F, quote = "", )
  })
  

  r73 <- rgdal::readGDAL("data/F_Ho.tif")
  r90 <- rgdal::readGDAL("data/B_Tm.tif")
  r232 <- rgdal::readGDAL("data/Ik.tif")
  #r233 <- rgdal::readGDAL("data/K_Ah_SUM.tif")
  #r266 <- rgdal::readGDAL("data/Aso_3.tif")
  #r267 <- rgdal::readGDAL("data/Aso_4.tif")
  #r269 <- rgdal::readGDAL("data/Aso2T.tif")
  #r274 <- rgdal::readGDAL("data/AT_SUM.tif")
  #r276 <- rgdal::readGDAL("data/Ata.tif")
  r299 <- rgdal::readGDAL("data/DKP.tif")
  r333 <- rgdal::readGDAL("data/Hk_TP.tif")
  #r369 <- rgdal::readGDAL("data/K_Tz.tif")
  #r373 <- rgdal::readGDAL("data/Kc_Hb.tif")
  #r415 <- rgdal::readGDAL("data/Ng.tif")
  #r438 <- rgdal::readGDAL("data/On_Pm1.tif")
  #r459 <- rgdal::readGDAL("data/SK.tif")
  #r461 <- rgdal::readGDAL("data/Spfa_1.tif")
  #r473 <- rgdal::readGDAL("data/To_BP1.tif")
  r488 <- rgdal::readGDAL("data/Toya.tif")
  r489 <- rgdal::readGDAL("data/Tp_HP.tif")
  #r492 <- rgdal::readGDAL("data/U_Oki.tif")
  
  ### Change raster data to raster Class for R ####
  r73w <- raster(r73)
  r90w <- raster(r90)
  r232w <- raster(r232)
  #r233w <- raster(r233)
  #r266w <- raster(r266)
  #r267w <- raster(r267)
  #r269w <- raster(r269)
  #r274w <- raster(r274)
  #r276w <- raster(r276)
  r299w <- raster(r299)
  r333w <- raster(r333)
  #r369w <- raster(r369)
  #r373w <- raster(r373)
  #r415w <- raster(r415)
  #r438w <- raster(r438)
  #r459w <- raster(r459)
  #r461w <- raster(r461)
  #r473w <- raster(r473)
  r488w <- raster(r488)
  r489w <- raster(r489)
  #r492w <- raster(r492)
  
  crs(r73w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  crs(r90w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  crs(r232w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r233w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r266w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r267w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r269w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r274w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r276w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  crs(r299w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  crs(r333w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r369w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r373w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r415w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r438w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r459w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r461w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r473w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  crs(r488w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  crs(r489w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  #crs(r492w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
 
  
  volcanoes <- rgdal::readOGR("data/Volcanoes.shp")
  crs(volcanoes) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  volc1 <- data.frame(volcanoes@coords)
  long4 <- volc1$coords.x1
  lat4 <- volc1$coords.x2
  volname <- volcanoes$NAME
  volc2 <-data.frame(long=long4, lat=lat4)
  
  VolcIcon <- makeIcon("data/Volc_icon_t.png", 24, 24)
  
    pal <- colorNumeric(c("blue", "yellow", "red"), c(10, 5000),
                        na.color = "transparent")
    
  output$mymap <- renderLeaflet({
    leaflet(volc2) %>%
      setView(139.69172,35.68948,zoom = 7) %>%
      addTiles(group = "OpenStreetMap") %>%
      addSearchOSM() %>%
      addMeasure(primaryLengthUnit = "meters", primaryAreaUnit = "sqmeters") %>%
      addMarkers(~long, ~lat, popup=volname, group="Volcanoes") %>%
      #addRasterImage(r373w, colors = pal, opacity = 0.3, group="Kutcharo IV") %>%
      addRasterImage(r90w, colors = pal, opacity = 0.3, group="Paektu-Tomakomai(B-Tm)") %>%
      #addRasterImage(r461w, colors = pal, opacity = 0.3, group="Shikotsu-Caldera(Spfa-1)") %>%
      addRasterImage(r488w, colors = pal, opacity = 0.3, group="Toya") %>%
      #addRasterImage(r415w, colors = pal, opacity = 0.3, group="Nigorikawa") %>%
      addRasterImage(r489w, colors = pal, opacity = 0.3, group="Towada-Hachinohe") %>%
      #addRasterImage(r473w, colors = pal, opacity = 0.3, group="Towada-Ohfudo") %>%
      #addRasterImage(r492w, colors = pal, opacity = 0.3, group="Ulleungdo-Oki") %>%
      #addRasterImage(r438w, colors = pal, opacity = 0.3, group="Ontake-Pm1") %>%
      addRasterImage(r73w, colors = pal, opacity = 0.3, group="Fuji_Hoei") %>%
      addRasterImage(r333w, colors = pal, opacity = 0.3, group="Hakone-Tokyo") %>%
      addRasterImage(r299w, colors = pal, opacity = 0.3, group="Daisen-Kurayoshi") %>%
      #addRasterImage(r459w, colors = pal, opacity = 0.3, group="Sambe-Kitsugi") %>%
      #addRasterImage(r267w, colors = pal, opacity = 0.3, group="Aso-4") %>%
      #addRasterImage(r266w, colors = pal, opacity = 0.3, group="Aso-3") %>%
      #addRasterImage(r274w, colors = pal, opacity = 0.3, group="Aira-Tanzawa") %>%
      #addRasterImage(r276w, colors = pal, opacity = 0.3, group="Ata") %>%
      addRasterImage(r232w, colors = pal, opacity = 0.3, group="Ikeda-Caldera") %>%
      #addRasterImage(r233w, colors = pal, opacity = 0.3, group="Kikai-Akahoya") %>%
      #addRasterImage(r369w, colors = pal, opacity = 0.3, group="Kikai-Tozurahara") %>%
      addLegend(pal = pal, values = c(10, 5000),
                title = "Tephra fall thickness (mm)", position="bottomleft", group ="Legend") %>%
      addLayersControl(
        overlayGroups = c("Volcanoes","Legend", "Paektu-Tomakomai(B-Tm)", "Toya", "Towada-Hachinohe", "Fuji_Hoei", "Hakone-Tokyo", "Daisen-Kurayoshi", "Ikeda-Caldera")) %>%  #, "Aso-4", "Kikai-Akahoya")) %>% #"Kutcharo IV","Paektu-Tomakomai(B-Tm)","Shikotsu-Caldera(Spfa-1)","Toya","Nigorikawa","Towada-Hachinohe","Towada-Ohfudo","Ulleungdo-Oki","Ontake-Pm1","Fuji_Hoei","Hakone-Tokyo","Daisen-Kurayoshi","Sambe-Kitsugi","Aso-4","Aso-3","Aira-Tanzawa","Ata","Ikeda-Caldera","Kikai-Akahoya","Kikai-Tozurahara")) %>%
      hideGroup("Paektu-Tomakomai(B-Tm)") %>%
      hideGroup("Ikeda-Caldera") %>%
      #hideGroup("Kikai-Akahoya") %>%
      #hideGroup("Ulleungdo-Oki") %>%
      #hideGroup("Nigorikawa") %>%
      hideGroup("Towada-Hachinohe") %>%
      #hideGroup("Aira-Tanzawa") %>%
      #hideGroup("Towada-Ohfudo") %>%
      #hideGroup("Shikotsu-Caldera(Spfa-1)") %>%
      hideGroup("Daisen-Kurayoshi") %>%
      hideGroup("Hakone-Tokyo") %>%
      #hideGroup("Aso-4") %>%
      #hideGroup("Kikai-Tozurahara") %>%
      #hideGroup("Ontake-Pm1") %>%
      hideGroup("Toya") 
      #hideGroup("Ata") %>%
      #hideGroup("Sambe-Kitsugi") %>%
      #hideGroup("Kutcharo IV") %>%
      #hideGroup("Aso-3")
        
      })
  
  output$loc <- renderTable({input$mymap_click
    })
  
  observe({
    
    removeModal()        
  
    observeEvent(input$goAction, {
    output$plot1 <- renderPlot({
      
      
      
      lat2 <- isolate(input$lat1)
      long2 <- isolate(input$long1)
      
      lat3 <- as.numeric(lat2)
      long3 <- as.numeric(long2)
      
      xy <- cbind(long3, lat3)
      df2 <- read.csv('data/No_and_age_list_fin.csv')
      dflabel <- read.table('data/label.csv',header = FALSE)
      TiffName <- df2$Tephra_Name..Tiff_file_name.
      leng <- length(TiffName)
      n <- 1:leng
      No <- dflabel 
      exvals <- data.frame()
      No2 <- data.frame()

      for (i in n){
        Tiffname <- paste0("data/", TiffName[i])
        r1 <- rgdal::readGDAL(Tiffname)
        r1w <- raster(r1)
        crs(r1w) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
        No3 <- extract(r1w, xy, method='simple', buffer=NULL)
        exvals <- rbind(exvals,No3)
        No2 <- rbind(No2,No[i,1])
        }

     combinePointValue <- cbind(No2,exvals)
     combinePointValue.t <- t(combinePointValue)
     write.table(combinePointValue.t,"data/combinedPointValue.csv", sep=",", row.names=FALSE, col.names=FALSE, quote=FALSE)

      
      library(zoo)
      library(pracma)
      library(sem)
      
      df1 <- read.csv('data/combinedPointValue.csv')
      df2 <- read.csv('data/No_and_age_list_fin.csv')
      df3 <- na.fill(df1,0)
      df4 <- as.numeric(df3[1,])
      df5 <- df2$Year_ka
      df6 <- data.frame(Year_ka=df5,Ashfall=df4)
      
      ### Here, we analyze the tephra fall record during the 150 ka! ### 
      ### If the database will be extended to older events, the treat should be change.####
      
      df_bool1 <- df6[df6$Year_ka >=0 & df6$Year_ka <10,]
      df_bool2 <- df6[df6$Year_ka >=10 & df6$Year_ka <20,]
      df_bool3 <- df6[df6$Year_ka >=20 & df6$Year_ka <30,]
      df_bool4 <- df6[df6$Year_ka >=30 & df6$Year_ka<40,]
      df_bool5 <- df6[df6$Year_ka >=40 & df6$Year_ka<50,]
      df_bool6 <- df6[df6$Year_ka >=50 & df6$Year_ka<60,]
      df_bool7 <- df6[df6$Year_ka >=60 & df6$Year_ka<70,]
      df_bool8 <- df6[df6$Year_ka >=70 & df6$Year_ka <80,]
      df_bool9 <- df6[df6$Year_ka >=80 & df6$Year_ka <90,]
      df_bool10 <- df6[df6$Year_ka >=90 & df6$Year_ka <100,]
      df_bool11 <- df6[df6$Year_ka >=100 & df6$Year_ka<110,]
      df_bool12 <- df6[df6$Year_ka >=110 & df6$Year_ka <120,]
      df_bool13 <- df6[df6$Year_ka >=120 & df6$Year_ka <130,]
      df_bool14 <- df6[df6$Year_ka >=130 & df6$Year_ka <140,]
      df_bool15 <- df6[df6$Year_ka >=140 & df6$Year_ka<150,]
      df_boolTot <- df6[df6$Year_ka<150,]
      
      W3 <- linspace(10, 3000, 300)
      W2 <- c(0.01, 0.1, 1)
      W <- c(W2, W3)
      
      J1 <- data.frame()
      J2 <- data.frame()
      J3 <- data.frame()
      J4 <- data.frame()
      J5 <- data.frame()
      J6 <- data.frame()
      J7 <- data.frame()
      J8 <- data.frame()
      J9 <- data.frame()
      J10 <- data.frame()
      J11 <- data.frame()
      J12 <- data.frame()
      J13 <- data.frame()
      J14 <- data.frame()
      J15 <- data.frame()
      JTot <- data.frame()
      
      for (i in W){
        Fi <- df_bool1$Ashfall > i
        Fin1 <- sum(Fi)
        df <- data.frame(Fin1)
        J1 <- rbind(J1, df)
      }
      
      for (i in W){
        Fi <- df_bool2$Ashfall > i
        Fin2 <- sum(Fi)
        df <- data.frame(Fin2)
        J2 <- rbind(J2, df)
      }
      
      for (i in W){
        Fi <- df_bool3$Ashfall > i
        Fin3 <- sum(Fi)
        df <- data.frame(Fin3)
        J3 <- rbind(J3, df)
      }
      
      for (i in W){
        Fi <- df_bool4$Ashfall > i
        Fin4 <- sum(Fi)
        df <- data.frame(Fin4)
        J4 <- rbind(J4, df)
      }
      
      for (i in W){
        Fi <- df_bool5$Ashfall > i
        Fin5 <- sum(Fi)
        df <- data.frame(Fin5)
        J5 <- rbind(J5, df)
      }
      
      for (i in W){
        Fi <- df_bool6$Ashfall > i
        Fin6 <- sum(Fi)
        df <- data.frame(Fin6)
        J6 <- rbind(J6, df)
      }
      
      for (i in W){
        Fi <- df_bool7$Ashfall > i
        Fin7 <- sum(Fi)
        df <- data.frame(Fin7)
        J7 <- rbind(J7, df)
      }
      
      for (i in W){
        Fi <- df_bool8$Ashfall > i
        Fin8 <- sum(Fi)
        df <- data.frame(Fin8)
        J8 <- rbind(J8, df)
      }
      
      for (i in W){
        Fi <- df_bool9$Ashfall > i
        Fin9 <- sum(Fi)
        df <- data.frame(Fin9)
        J9 <- rbind(J9, df)
      }
      
      for (i in W){
        Fi <- df_bool10$Ashfall > i
        Fin10 <- sum(Fi)
        df <- data.frame(Fin10)
        J10 <- rbind(J10, df)
      }
      
      for (i in W){
        Fi <- df_bool11$Ashfall > i
        Fin11 <- sum(Fi)
        df <- data.frame(Fin11)
        J11 <- rbind(J11, df)
      }
      
      for (i in W){
        Fi <- df_bool12$Ashfall > i
        Fin12 <- sum(Fi)
        df <- data.frame(Fin12)
        J12 <- rbind(J12, df)
      }
      
      for (i in W){
        Fi <- df_bool13$Ashfall > i
        Fin13 <- sum(Fi)
        df <- data.frame(Fin13)
        J13 <- rbind(J13, df)
      }
      
      for (i in W){
        Fi <- df_bool14$Ashfall > i
        Fin14 <- sum(Fi)
        df <- data.frame(Fin14)
        J14 <- rbind(J14, df)
      }
      
      for (i in W){
        Fi <- df_bool15$Ashfall > i
        Fin15 <- sum(Fi)
        df <- data.frame(Fin15)
        J15 <- rbind(J15, df)
      }
      
      for (i in W){
        Fi <- df_boolTot$Ashfall > i
        FinTot <- sum(Fi)
        df <- data.frame(FinTot)
        JTot <- rbind(JTot, df)
      }
      
      JTot1 <- cbind(J1,J2)
      JTot2 <- cbind(JTot1,J3)
      JTot3 <- cbind(JTot2,J4)
      JTot4 <- cbind(JTot3,J5)
      JTot5 <- cbind(JTot4,J6)
      JTot6 <- cbind(JTot5,J7)
      JTot7 <- cbind(JTot6,J8)
      JTot8 <- cbind(JTot7,J9)
      JTot9 <- cbind(JTot8,J10)
      JTot10 <- cbind(JTot9,J11)
      JTot11 <- cbind(JTot10,J12)
      JTot12 <- cbind(JTot11,J13)
      JTot13 <- cbind(JTot12,J14)
      JTot14 <- cbind(JTot13,J15)
      
      Z <- data.frame()
      Zav <- data.frame()
      Parameters <- data.frame()
      Prob1 <- data.frame()
      Prob2 <- data.frame()
      Prob3 <- data.frame()
      Conf_95 <- data.frame()
      av <- data.frame()
      Pc <- data.frame()
      
      n <- length(W)
      n2 <- linspace(1, n, n)
      
      poisson <- function(k, lamb){
        value <- (lamb^k/factorial(k)*exp(-lamb))
        return(value)
      }
      
      alpha <- 0.95
      data <- data.frame()
      
      for (i in n2){
        data1 <- as.numeric(J1[i,])
        Zav1 <- mean(data1)/10000 # recent 10 ka
        data2 <- as.numeric(JTot1[i,]) # recent 20 ka
        Zav2 <- mean(data2)/10000
        data3 <- as.numeric(JTot2[i,]) # recent 30 ka
        Zav3 <- mean(data3)/10000
        data4 <- as.numeric(JTot3[i,]) # recent 40 ka
        Zav4 <- mean(data4)/10000
        data5 <- as.numeric(JTot4[i,]) # recent 50 ka
        Zav5 <- mean(data5)/10000
        data6 <- as.numeric(JTot5[i,]) # recent 60 ka
        Zav6 <- mean(data6)/10000
        data7 <- as.numeric(JTot6[i,]) # recent 70 ka
        Zav7 <- mean(data7)/10000
        data8 <- as.numeric(JTot7[i,]) # recent 80 ka
        Zav8 <- mean(data8)/10000
        data9 <- as.numeric(JTot8[i,]) # recent 90 ka
        Zav9 <- mean(data9)/10000
        data10 <- as.numeric(JTot9[i,]) # recent 100 ka
        Zav10 <- mean(data10)/10000
        data11 <- as.numeric(JTot10[i,]) # recent 110 ka
        Zav11 <- mean(data11)/10000
        data12 <- as.numeric(JTot11[i,]) # recent 120 ka
        Zav12 <- mean(data12)/10000
        data13 <- as.numeric(JTot12[i,]) # recent 130 ka
        Zav13 <- mean(data13)/10000
        data14 <- as.numeric(JTot13[i,]) # recent 140 ka
        Zav14 <- mean(data14)/10000
        data15 <- as.numeric(JTot14[i,]) # recent 150 ka
        Zav15 <- mean(data15)/10000
        Zav16 <- rbind(Zav1,Zav2)
        Zav17 <- rbind(Zav16,Zav3)
        Zav18 <- rbind(Zav17,Zav4)
        Zav19 <- rbind(Zav18,Zav5)
        Zav20 <- rbind(Zav19,Zav6)
        Zav21 <- rbind(Zav20,Zav7)
        Zav22 <- rbind(Zav21,Zav8)
        Zav23 <- rbind(Zav22,Zav9)
        Zav24 <- rbind(Zav23,Zav10)
        Zav25 <- rbind(Zav24,Zav11)
        Zav26 <- rbind(Zav25,Zav12)
        Zav27 <- rbind(Zav26,Zav13)
        Zav28 <- rbind(Zav27,Zav14)
        Zav29 <- rbind(Zav28,Zav15)
        mean2 <- mean(Zav29)
        mean_val <- data.frame(mean2)
        av <- rbind(av, mean_val)
        sem_val <- sd(Zav29)/sqrt(15)
        ci <- qt(alpha, df=14)*sem_val
        ci2 <- data.frame(ci)
        Conf_95 <- rbind(Conf_95, ci2)
      }
      
      Conf_95_max <- av + Conf_95
      Conf_95_min <- av - Conf_95
      
      ###Cumulative frequency of tephra fall for the past 150 ka
      Cum_freq_150 <- data.frame()
      n <- linspace(1,303,303)
      for (i in n){
        J <- JTot14[i,]
        Cum <- sum(J)
        Cum_freq_150 <- rbind(Cum_freq_150, Cum)
      }
      
      Cum_freq_150 <- cbind(W,Cum_freq_150)
      mean_values <- cbind(W,av[,1])
      Conf_95_max <- cbind(W,Conf_95_max)
      Conf_95_min <- cbind(W,Conf_95_min)
      
      rezhaz <- data.frame()
      
      rezhaz <- cbind(Tephra_fall_thickness_mm = W,AFE_mean = mean_values[,2],Conf_95_max=Conf_95_max[,2],Conf_95_min=Conf_95_min[,2])
      write.csv(rezhaz,"data/hazard_result.csv", row.names=FALSE, quote=FALSE)
      
      output$haz <- renderTable(
        read.csv("data/hazard_result.csv"), digits=-2)
      
      layout(matrix(1:2, ncol=2)) 
      plot(Cum_freq_150, type="l", log='x', xlab="Tephra fall thickness (mm)", ylab="Number of events", ylim=c(0,30)) #,xaxt="n",yaxt="n")
      plot(mean_values, type="l", log='xy', xlab="Tephra fall thickness (mm)", ylab="Mean annual frequency of exceedance", main= "hazard curve", ylim=c(10^-6,10^-3)) #,xaxt="n",yaxt="n")
      points(Conf_95_max, type="l", col="red")
      points(Conf_95_min, type="l", col="red")
      
      output$downloadData1 <- downloadHandler(
        filename = "hazard_result.csv", content = function(file){
          PATH2 <- "data/hazard_result.csv"
          data <- read.table(PATH2, sep=",", header=TRUE, check.names=F)
          write.csv(data,file)}
      )
      })
      
    })
  })
})
