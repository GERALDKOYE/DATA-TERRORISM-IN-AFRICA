rm(list=ls())
#*****Environnement de travail
setwd("D:\\ETUDES\\3A\\Semestre 2\\Data StoryTelling\\gtd")
library(data.table)
donnee<-fread("globalterrorismdb_0718dist.csv")

#donnee.iloc[:,20:].head().T
#country_txt,region_txt,city, iyear,attacktype1_txt,attacktype2_txt,attacktype3_txt,
#targtype1_txt,targsubtype1_txt,target1,natlty1_txt,corp1,ransom, 
#natlty3_txt, gname, weaptype1_txt, weapsubtype1_txt, 
#addnotes, scite1-scite3
#donnee[['gname','natlty3_txt']]
#donnee['gname'].value_counts()[:100]

#Definition des pays
rm(pays)
pays=append(sort(unique(donnee$country_txt[donnee$region==10]))[c(1,3,11,12,18,
                                                                 22)],unique(donnee$country_txt[donnee$region==11]))
#Statistiques descriptives
library(dplyr)
library(ggplot2)

bar.visualisation<-function(variables,nb){
  # Tableau d'Effectifs
  Freq.Pop<-donnee%>%
    filter(country_txt%in%pays)%>%
    group_by(.dots=variables) %>%
    summarize(Effectif= n())%>%
    arrange(desc(Effectif))
  
  n=min(nb,nrow(Freq.Pop)) #Critère de selection des données à visualiser
  Freq.Pop30<-Freq.Pop[1:n,] #selection des donnees
  #View(Freq.Pop30)
  
  #******* Barplot: Representation des n plus grandes sous populations
  Freq.Pop30[,variables]<-Freq.Pop30%>%select(.dots=variables)%>%
    mutate_if(is.character, as.factor)
  
  #View(Freq.Pop30)
  names(Freq.Pop30)[1]<-"Var"
  p<-ggplot(data=Freq.Pop30, aes(x=factor(Var), y=Effectif,fill=Effectif)) +
    geom_bar(stat="identity")+ coord_flip()+theme_minimal()
  
  windows()
  p+labs(x=variables,y="Effectif")
}

#***Identification des armes les plus utilisées
bar.visualisation("weaptype1_txt",30)

#****Construction de données pour les statistiques descriptives
mode_donne_pays_anne<-donnee%>%
  filter(country_txt%in%pays) %>%
  group_by(gname,iyear, weaptype1_txt) %>%
  summarize(Effectif= n())%>%
  arrange(desc(Effectif))

#****La correlation entre les armes et les acteurs
Freq.table<-donnee%>%
  filter(country_txt%in%pays)%>%
  group_by(weaptype1_txt) %>%
  summarize(Effectif= n())%>%
  arrange(desc(Effectif))

Freq.table<-Freq.table%>%filter(Effectif>=100)

#***Armes les plus utilisées
arme_plus_utilise<-unique(Freq.table$weaptype1_txt)

(Freq.table$weaptype1_txt[2:4])
arme_mode<-donnee%>%
  filter(country_txt%in%pays,weaptype1_txt%in%Freq.table$weaptype1_txt[c(1,2,4,5)],gname!="Unknown")%>%
  group_by(weaptype1_txt,gname) %>%
  summarize(Effectif= n())%>%
  arrange(desc(Effectif))

#***Détermination du 95ème percentile
indice<-arme_mode%>%
  group_by(weaptype1_txt)%>%
  summarize(Quantile90= quantile(Effectif,probs=0.95))%>%
  arrange(desc(Quantile90))

#****Données à representer: rajout du 95ème percentile
arme_mode<-left_join(arme_mode,indice,by="weaptype1_txt")

#***Selection des données au dela du 95ème percentile
arme_mode90<-arme_mode%>%filter(Effectif>=Quantile90)


p<-ggplot(arme_mode90, aes(x=gname, y=Effectif,fill=Effectif)) +
  geom_bar(stat='identity', position='dodge')+facet_wrap(~ weaptype1_txt)+theme_minimal()+coord_flip()
windows()
p

#*****Representation de l'évolution des armes utilisées selon les acteurs ou groupe terroristes
##Acteurs principaux :Boko Haram,Al-Shabaab
Freq.Pop<-donnee%>%
  filter(country_txt%in%pays)%>%
  group_by(.dots=c("gname","iyear","weaptype1_txt")) %>%
  summarize(Effectif=n())%>%
  arrange(desc(Effectif),gname,iyear)

aa<-Freq.Pop%>%filter(iyear>2015,weaptype1_txt %in% arme_plus_utilise,Effectif>10)%>%
  arrange(desc(Effectif))

liste_des_acteurs_les_plus_envue<-unique(aa$gname)[1:20]

#for (j in rev(1:10)){
#j=5
graph_1<-function(j){
dta<-Freq.Pop%>%filter(gname==liste_des_acteurs_les_plus_envue[j])
windows()
p<-ggplot(dta, aes(x=weaptype1_txt, y=Effectif,fill=Effectif)) +
  geom_bar(stat='identity', position='dodge')+facet_wrap(~ iyear)+theme_minimal()+coord_flip()+ggtitle(liste_des_acteurs_les_plus_envue[j])
#windows()
p
#dev.off()
}
j=2
graph_1(j)

liste_des_acteurs_les_plus_envue
View(donnee%>%
       filter(country_txt%in%pays,gname=="Fulani extremists")%>%select(country_txt)%>%unique())
#Al-Shabaab, Il utilise plus les explosives que les armes, cependant il y a une nette augmentation des armes (proportion quasi-égale) en 2014 et 2015
##Explication:suite au changement de stratégie d'al-Shabaab, dont les actions, surtout à Mogadiscio, sont devenues toujours plus destructives et ciblées. 

#Changement de la structure de Boko Haram, je dois raconter l'histoire. Passage à l'utilisation des explosives plutot que les armes à feu à partir 2014.
##Explication: 

#Fulani extremists, ils utilisent bcp d'armes à feu, un peu d'indendie et de melée
#Tripoli Province of the Islamic State, explosives, armes à feu, melee
#Sinai Province of the Islamic State, explosive, armes à feu,
#Mozambique National Resistance Movement (MNR), armes à feu
#Niger Delta Avengers (NDA), explosives
#Barqa Province of the Islamic State,explosives, armes à feu, 
#Allied Democratic Forces (ADF), armes à feu, melee, un peu incendies, un peu explosives, 
#12) Muslim extremists,changement de la structure (passage aux armes à feu au detriment des explosives à partir de 2016)


install.packages("rAmCharts")
library(rAmCharts)
data("data_stock_2")
amTimeSeries(data_stock_2, "date", c("ts1", "ts2"))
View(data_stock_2)

#****Construire un graphe d'evolution de l'utilisation de chaque arme par groupe terrorisme
