
arch = open('pokemonentries.csv','r')
for linea in arch:
    partes = linea.split(',')
    string = partes[0]+','
    for x in partes[1:]:
        string+=x.replace(","," ")
    if string:
        print string.replace("\n","")