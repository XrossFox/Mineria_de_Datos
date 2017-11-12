# -*- coding: utf-8 -*-
from selenium import webdriver 
import sys
reload(sys)  
sys.setdefaultencoding('utf-8')
print ("Nombre,Descripcion")
archivo = open("pokemonlinks.txt","r" )
lineas = archivo.readlines()
lineas = set(lineas)
lineas = list(lineas)
lineas.sort()
browser = webdriver.PhantomJS()
i = 1
for linea in lineas:

    
    browser.get(linea)

    nombre_pk = browser.find_element_by_tag_name("h1")
    #print (browser.page_source)
    #numero_pk = browser.find_element_by_xpath('//*[@id="svtabs_basic_1"]/div[1]/div[2]/table/tbody/tr[1]/td/strong')
    #numero_pk = browser.find_element_by_xpath('//*[text()[contains(.,"svtabs_basic")]]/div[1]/div[2]/table/tbody/tr[1]/td/strong')
    tabla_entries = browser.find_element_by_xpath('/html/body/article/table')
    rows = tabla_entries.find_elements_by_tag_name("tr")
    campo = rows[len(rows)-1].find_element_by_tag_name("td")

    print (nombre_pk.text+","+campo.text)


archivo.close()
browser.close()
#
#pokemones = browser.find_elements_by_tag_name("a")

#for pokemon in pokemones:
#    if "pokedex" in str(pokemon.get_attribute("href")):
#        print (pokemon.get_attribute("href"))

