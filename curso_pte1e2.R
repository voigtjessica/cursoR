#Aula - conceitos b?sicos de R!

# Ol?, com a ajuda desse script vamos aprender a fazer coisas b?sicas no R!,
# como visualizar planilhas, selecionar colunas,
# realizar pequenas opera??es matem?ticas.

#Primeiro, use o # para anotar

#Camos come?ar com opera??es matem?ticas
#Voc? pode anotar no console ou no script. E voc? pode atribuir o resultado a um objeto.

1+2

25.55 * 88.79

x <- 1+2

#Vamos remover esse x in?til?

rm(x)

# Para elaborar um banco de dados a l?gica ? muito parecida.
# Um jeito que eu gosto de trabalhar e que eu n?o acho confuso ? primeiro criar as vari?veis e 
# depois criar o banco de dados (dataframe). 

#Problema: O cebolinha foi na quitanda e comprou 4 ma??s, 5 p?ras, 8 tomates e 1 cebola. Fa?a um df com essas infos:

produto <- c("ma??","p?ra","tomate","cebola")  #Nunca coloque acentos ou espa?o nos nomes das vari?veis. J? nos nomes dos valores n?o tem problema colocar acento
qtde <- c(4,5,8,1)   #Aqui s?o n?meros, eles s?o calcul?veis, ent?o eles n?o t?m aspas.

#Agora que criamos as vari?veis, vamos criar o df

df_cebolinha <- data.frame(produto, qtde)

#Eu gosto de colocar uma refer?ncia aos nomes para n?o me perder. Agora vamos ver como ficou esse df

View(df_cebolinha)    #Sim, o V ? com letra mai?scula. S? nessa fun??o isso acontece.

#Agora, vamos dizer que queremos saber quais produtos o cebolinha comprou, sem olhar no df (o que aconteceria 
#caso o cebolinha fosse um comerciante e comprasse muita coisa). Ent?o vamos lembrar quais s?o os 
#nomes das colunas que n?s temos aqui:

names(df_cebolinha)

#Agora vamos olhar o que tem dentro da coluna "produto"

unique(df_cebolinha$produto)

#Digamos que eu quero saber s? como ? a cara desse df, podemos fazer da seguinte forma:

head(df_cebolinha)

#Como temos poucos produtos, apareceu o df inteiro. Mas em bancos maiores ele aparece s? as primeiras linhas.

#Agora vamos dizer que eu quero somar tudo o que o cebolinha comprou e que est? nesse df. 
# Primeiro vamos descobrir se a coluna qtde tem valores num?ricos:

is.numeric(df_cebolinha$qtde)

#?timo. Posso realizar opera??es matem?ticas com ele. Agora para eu somar eu fa?o isso da seguinte
#maneira:

sum(df_cebolinha$qtde)

#Agora queremos salvar essa lista em algum lugar. Primeiro vamos dizer ao R! onde queremos que salve:

setwd("C:/Users/jvoig/OneDrive/Documentos/Curso_R/Parte_1") #As barras sempre /

#Agora vamos salvar a planilha como um .csv , onde o separador ? ; e as casas decimais s?o representadas com , :

write.table(df_cebolinha,file="df_cebolinha.csv", sep=";", dec=",", row.names = FALSE)

#Bacana. Agora podemos seguir para a parte 2!

##############################################################

#A parte 2 vai tentar abordar tudo o que pode dar errado em uma importa??o de planilha.
#Vamos come?ar importando uma planilha de verdade! A lista de compras da M?nica, uma planilha CSV
#parecida com a que a gente exportou. 

#Primeiro: avise o computador onde est? essa planilha:

setwd("C:/Users/jvoig/OneDrive/Documentos/Curso_R/Parte_1/planilhas_exemplo")

df_monica <- read.table(file = "df_monica.csv")
View(df_monica)

#A planilha veio toda cagada, n?o?
#Ela est? salva nos mesmos termos que n?s salvamos a lista de compras do cebolinha. Voc?s conseguem
#pensar em quais argumentos temos que acrescentar no comando read.table pra ele ler a planilha corretamente?

#default do separador do csv ? "," , mas muitas planilhas setam, que nem n?s setamos, para ";" 

df_monica <- read.table(file = "df_monica.csv", sep=";")
View(df_monica)

# Parece que est? tudo certo, n?? Pois bem, n?o est?.
# Isso porque temos que confirmar que a coluna de qtde corresponde a valores num?ricos mesmo. Vamos ver?

is.numeric(df_monica$qtde)

#Eita, pq ser?? Temos que avisar que o decimal ? "," e avisar qual coluna ? o que:

df_monica <- read.table(file = "df_monica.csv", sep=";",
                        header = TRUE, dec=",", colClasses=c("character", "numeric"))
View(df_monica)
is.numeric(df_monica$qtde)

#Agora foi!

#Agora vamos pensar em juntar esses dois bancos, mas eu gostaria de saber o que foia  monica
# que comprou e o que foi o cebolinha. Ent?o vou criar uma coluna para cada df com o nome deles


df_cebolinha["nome"] <-c("cebolinha")
View(df_cebolinha)

df_monica["nome"] <-c("m?nica")
View(df_monica)

#Pronto, agora podemos juntar as colunas sabendo o que ? de quem.
# Para isso, vamos come?ar a usar o pacote dplyr

library(dplyr)

compras <- bind_rows(df_cebolinha, df_monica)
View(compras)

#Agora, para terminar hoje, vamos s? selecionar o que n?s queremos para ver essa coluna

names(compras)
compras <- select(compras, produto, qtde)

# Por fim, vamos salvar esse data.frame. Primeiro avisar onde vamos deixar o arquivo:

setwd("C:/Users/jvoig/OneDrive/Documentos/Curso_R/Parte_1")
write.table(compras, file="compras.csv", sep = ";", dec=",", row.names = FALSE)


########################################################################
#Problema 1: Magali comprou 58 melancias, 27 abacaxis, 3 pepinos e 12 tangerinas . 
#Crie um banco de dados com a lista de compras da Magali

#Problema 2: Crie um objeto com a soma da coluna onde est?o as compras da magali

#Problema 3: Crie um novo dataframe contendo a lista de compras do cebolinha, da m?nica e 
#da magali onde se consiga saber exatamente quem comprou o qu?

#Problema 4: Salve o dataframe do problema 3 como uma planilha .csv , usando ponto e v?rgula
# como separador das colunas, v?rgula como separador decimal e row.names = F




