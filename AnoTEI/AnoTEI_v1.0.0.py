# El usuario indica el poema
print("Indica qué poema que quieres transformar")
archivoPoema = input("Nombre del archivo (sin extensión: ")

# Abre el archivo indicado, añadiendo la extensión .txt y codificación
# UTF-8. Lee el poema línea a línea y lo guarda en una variable
with open(archivoPoema + '.txt', mode='r', encoding="utf-8") as poema:
  lineasPoema = poema.readlines()

# Si el archivo está vacío, lo indica antes de continuar. Si no, pide
# al usuario que introduzca el título del poema que aparecerá anotado
# y que añada un identificador
if lineasPoema == []:
  print("El archivo que has seleccionado está vacío.")
else:
  tituloPoema = input("Título del poema: ")
  idPoema = input("ID del poema (se recomienda introducir 4 dígitos): ")

  # Cabecera de TEI
  header = """<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
   <teiHeader>
      <fileDesc>
         <titleStmt>
            <title></title>
         </titleStmt>
         <publicationStmt>
            <p></p>
         </publicationStmt>
         <sourceDesc>
            <p></p>
         </sourceDesc>
      </fileDesc>
   </teiHeader>
   <text>
      <body>\n"""

  # Incluye el título del poema introducido por el usuario
  head = "         <head>{}</head>\n".format(tituloPoema)

  # Incluye el ID del poema introducido por el usuario
  body = '         <lg xml:id="P{}">\n'.format(idPoema)

  # Cierre de TEI
  footer = """            </lg>
         </lg>
      </body>
   </text>
</TEI>"""

  # Variable que se irá reescribiendo a lo largo del poema para ir
  # añadiendo los versos según se vayan leyendo. Contiene, además,
  # la anotación de la primera estrofa
  salida = '            <lg xml:id="P{}E0001">\n'.format(idPoema)

  # Contadores para la numeración de versos y estrofas
  nverso = 0
  nestrofa = 1

  # Recorre todas las líneas menos la última 
  for linea in lineasPoema[:-1]:
    # Si la línea solo tiene un carácter, este es un salto de línea
    # Cierra la estrofa y abre la siguiente
    if len(linea) == 1:
      nestrofa += 1
      cestrofa = '{:04.0f}'.format(nestrofa)
      salida = salida + '            </lg>\n            <lg xml:id="P{}E{}">\n'.format(idPoema, cestrofa)
    # Todas las líneas de verso salvo la última acaban con un salto de
    # línea, ignora el último carácter para que l se cierre en la misma
    # línea
    else:
      linea = linea[:-1]
      nverso += 1
      cverso = '{:04.0f}'.format(nverso)
      salida = salida + '               <l xml:id="P{}V{}">{}</l>\n'.format(idPoema, cverso, linea)
  
  # si la línea es la última, no hace falta que ignore el último carácter
  linea = lineasPoema[-1]
  nverso += 1
  cverso ='{:04.0f}'.format(nverso)
  salida = salida + '               <l xml:id="P{}V{}">{}</l>\n'.format(idPoema, cverso, linea)

  # el usuario introduce el nombre que quiere para su archivo .tei.xml y
  # se genera
  print("Indica el nombre del archivo TEI transformado que quieres obtener")
  outFile = input("Nombre del archivo (sin extensión): ") + ".tei.xml"


  with open(outFile, mode="w", encoding="utf-8") as poemaAnotado:
    # escribimos todo, incluyendo la cabecera y el cierre de TEI      
    poemaAnotado.write(header)
    poemaAnotado.write(head)
    poemaAnotado.write(body)
    poemaAnotado.write(salida)
    poemaAnotado.write(footer)