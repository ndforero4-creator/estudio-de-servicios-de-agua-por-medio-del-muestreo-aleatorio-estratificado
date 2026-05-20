#Muestreo aleatorio estratificado
#aproximacion al tamaño de muestra total 
#calcular (el tamaño de cada estrato) 
N1<-length(na.omit(gastoH20$bogota)) 
N2<-length(na.omit(gastoH20$cali)) 
N3<-length(na.omit(gastoH20$medellin)) 
N4<-length(na.omit(gastoH20$cartagena)) 
N=N1+N2+N3+N4 
N

#desviacion estandar por estrato 
sapply(gastoH20,sd,na.rm=TRUE) 
ds1<-sd(na.omit(gastoH20$bogota)) 
ds2<-sd(na.omit(gastoH20$cali)) 
ds3<-sd(na.omit(gastoH20$medellin)) 
ds4<-sd(na.omit(gastoH20$cartagena))

#costo una llamada en el estrato i
C1=3000  
C2=2500 
C3=2800 
C4=2600 
E=20 

#error de veinte mil pesos 
#aproximacion al tamaño de muestra n 
num<-((N1*ds1/sqrt(C1))+(N2*ds2/sqrt(C2))+ (N3*ds3/sqrt(C3))+(N4*ds4/sqrt(C4)))* ((N1*ds1*sqrt(C1))+(N2*ds2*sqrt(C2))+ (N3*ds3*sqrt(C3))+(N4*ds4*sqrt(C4))) 
den<-(N^2*E^2/4)+(N1*ds1^2+N2*ds2^2+N3*ds3^2+N4*ds4^2) 
n=round(num/den,0) 
n=340 

#se necesitan para realizar el muestreo un total de 340 encuestas 
nbogota<-round(n*(N1*ds1/sqrt(C1))/((N1*ds1/sqrt(C1))+(N2*ds2/sqrt(C2))+ (N3*ds3/sqrt(C3))+(N4*ds4/sqrt(C4))),0) 
#se necesitan 91 encuestas en la ciudad de Bogota 
ncali<-round(n*(N2*ds2/sqrt(C2))/((N1*ds1/sqrt(C1))+(N2*ds2/sqrt(C2))+ (N3*ds3/sqrt(C3))+(N4*ds4/sqrt(C4))),0) 
#se necesitan 87 encuestas en la ciudad de cali 
nmedellin<-round(n*(N3*ds3/sqrt(C3))/((N1*ds1/sqrt(C1))+(N2*ds2/sqrt(C2))+ (N3*ds3/sqrt(C3))+(N4*ds4/sqrt(C4))),0) 
#se necesitan 59 encuestas en la ciudad de medellin 
ncartagena<-round(n*(N4*ds4/sqrt(C4))/((N1*ds1/sqrt(C1))+(N2*ds2/sqrt(C2))+ (N3*ds3/sqrt(C3))+(N4*ds4/sqrt(C4))),0) 
#se necesitan 103 encuestas en la ciudad de cartagena

#limpiar el archivo eliminando las celdas sin datos
bogota<-gastoH20$bogota[!is.na(gastoH20$bogota)]
cali<-gastoH20$cali[!is.na(gastoH20$cali)]
medellin<-gastoH20$medellin[!is.na(gastoH20$medellin)]
cartagena<-gastoH20$cartagena[!is.na(gastoH20$cartagena)]

#seleccionar la muestra para cada uno de los estratos
bogota<-sample(bogota, size = 91, replace = TRUE)
cali<-sample(cali, size = 87, replace = TRUE)
medellin<-sample(medellin, size = 57, replace = TRUE)
cartagena<-sample(cartagena, size = 103, replace = TRUE)

#graficar
library(ggplot2)
library(patchwork)
a<-ggplot(data=data.frame(bogota))+aes(x=bogota, y="")+
  geom_boxplot(color="black", size=1.5, fill="#AEE881", alpha=0.5)+
         geom_jitter()+
  ggtitle("Gasto en agua Bogotá")+xlab("Valor en miles")+ylab("")+
         theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"))
a

b<-ggplot(data=data.frame(cali))+aes(x=cali, y="")+
  geom_boxplot(color="black", size=1.5, fill="#7EF0E3", alpha=0.5)+
  geom_jitter()+
  ggtitle("Gasto en agua Cali")+xlab("Valor en miles")+ylab("")+
  theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"))
b

c<-ggplot(data=data.frame(medellin))+aes(x=medellin, y="")+
  geom_boxplot(color="black", size=1.5, fill="#FA3B3B", alpha=0.5)+
  geom_jitter()+
  ggtitle("Gasto en agua Medellín")+xlab("Valor en miles")+ylab("")+
  theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"))
c

d<-ggplot(data=data.frame(cartagena))+aes(x=cartagena, y="")+
  geom_boxplot(color="black", size=1.5, fill="#FFC300", alpha=0.5)+
  geom_jitter()+
  ggtitle("Gasto en agua Cartagena")+xlab("Valor en miles")+ylab("")+
  theme(plot.title = element_text(size = 20, hjust = 0.5, vjust = 0.5, face = "bold"))
d
a+b+c+d

#Estimacion de la media en el muestreo aleatorio estratificado
media.mae.agua<-round((1/N)*(N1*mean(bogota)+N2*mean(cali)+
                               N3*mean(medellin)+N4*mean(cartagena)),2)
media.mae.agua

#Utilizando muestreo aleatorio estratificado, en promedio las familias pagan
#en agua un valor promedio de 444.54 mil pesos

#Calcular la varianza en muestreo aleatorio estratificado

var.agua.mae<-(1/N^2)*((N1^2*var(bogota)/nbogota)*((N1-nbogota)/N1)+
                         (N2^2*var(cali)/ncali)*((N2-ncali)/N2)+
                         (N3^2*var(medellin)/nmedellin)*((N3-nmedellin)/N3)+
                         (N4^2*var(cartagena)/ncartagena)*((N4-ncartagena)/N4))
var.agua.mae

#intervalo de confianza para la media en el muestreo aleatorio estratificado
lsc.media.mae<-media.mae.agua+2*sqrt(var.agua.mae)
lsc.media.mae                      
lic.media.mae<-media.mae.agua-2*sqrt(var.agua.mae)
lic.media.mae 

#Estimacion del total del muestreo aleatorio estratificado
total.h2o.mae<-N1*mean(bogota)+N2*mean(cali)+N3*mean(medellin)+N4*mean(cartagena)
total.h2o.mae
#En total las familias pagan 3025256.01515893 pesos

#Estimacion del error
error.h2o.mae<-2*sqrt(N1^2*(var(bogota)/nbogota)*(N1-nbogota)/N1+
                N2^2*(var(cali)/ncali)*(N2-ncali)/N2+
                 N3^2*(var(medellin)/nmedellin)*(N3-nmedellin)/N3+
                   N4^2*(var(cartagena)/ncartagena)*(N2-ncartagena)/N4)
error.h2o.mae

#Intervalo de confianza para el total
lsc.total.mae<-total.h2o.mae+error.h2o.mae
lsc.total.mae
lic.total.mae<-total.h2o.mae-error.h2o.mae
lic.total.mae

#En total las familias pagan 3166395 entre y 2884117 pesos

#Estimacion de la proporcion en el muestreo aleatorio estratificado
#Estimar la proporción de familias que pagan menos de 200.000 pesos
bog<-numeric()
bog[bogota<=200]<-1
bog
table(bog)
pro.bog<-14/nbogota
pro.bog
#en Bogota el 16% de las familias menos de 200 mil pesos en agua

cal<-numeric()
cal[cali<=200]<-1
cal
table(cal)
pro.cal<-12/ncali
pro.cal
#en Cali el 13% de las familias menos de 200 mil pesos en agua

med<-numeric()
med[medellin<=200]<-1
med
table(med)
pro.med<-10/nmedellin
pro.med
#en Medellin el 16.9% de las familias menos de 200 mil pesos en agua

car<-numeric()
car[cartagena<=200]<-1
car
table(car)
pro.car<-10/ncartagena
pro.car
#en cartagena el 9.6% de las familias menos de 200 mil pesos en agua

#estimacion de la proporción en el muestreo aleatorio estratificado
prop.mae<-round((1/N)*((N1*pro.bog)+
                  (N2*pro.cal)+
                    (N3*pro.med)+
                      (N4*pro.car)),2)
prop.mae

#estimacion del error en el muestreo aleatorio estratificado
e.prop.mae<-2*sqrt((1/N^2)*(
                        (N1^2*(pro.bog*(1-pro.bog))/(nbogota-1))*((N1-nbogota)/N1)+
                        (N2^2*(pro.cal*(1-pro.cal))/(ncali-1))*((N2-ncali)/N2)+
                        (N3^2*(pro.med*(1-pro.med))/(nmedellin-1))*((N3-nmedellin)/N3)+
                        (N4^2*(pro.car*(1-pro.car))/(ncartagena-1))*((N4-ncartagena)/N4))
                          )
e.prop.mae


#Intervalo de confianza para la proporción en el MAE

lsc.prop.mae<-round(prop.mae+e.prop.mae,2)
lsc.prop.mae
lic.prop.mae<-round(prop.mae-e.prop.mae,2)
lic.prop.mae
