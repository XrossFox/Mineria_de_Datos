import csv
#with open('pokemon.csv') as arc1:
arc1 = open('pokedex.csv')
csvfile = open('pokemon.csv')
reader = csv.DictReader(csvfile)
reader2 = csv.DictReader(arc1)
i=1
datasetknn = [row for row in reader]
datasetpokedex = [row for row in reader2]

print "name,pokedex,is_legendary"
for row in datasetknn:
    
    for x in datasetpokedex:
        if row['name'] == x['Nombre']:
            print row['name']+','+x['Descripcion']+','+row['is_legendary']
            