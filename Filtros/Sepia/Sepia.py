'''Librería para el manejo de la imagen
Para el manejo de la imagen y los pixeles de la misma se puede usar una libería
ya que esto se va a hacer de otra forma (ya conocida) en Cpulator
'''

# Debo cambiar la lista de los pixeles?

from PIL import Image
#from mult import multiplicar
#from div import division

def sepia_filter(img_sepia):

    pixelList =[] # Variable para guardar los pixeles de la imagen en una list
    newPixelList = [] # Varaibles para guardar los pixeles con el filtro

    width, height = img_sepia.size # Obtiene el tamaño de la imagen
    pixels = img_sepia.load() # Crea un objeto de pixeles

    # Guardar los pixeles en una lista
    for y in range(height):
        for x in range(width):
            pixelList.append(pixels[x,y])


    # Aplicar el filtro
    for py in range(height):
        for px in range(width):
            r, g, b = img_sepia.getpixel((px, py)) # Cambiarlo para que sean los de la lista

            # Valores predefinidos para crear el filtro
            # Valores para el rojo
            rr = 393
            rg = 769
            rb = 189

            # Valores para el verde
            gr = 349
            gg = 686
            gb = 168

            # Valores para el azul
            br = 272
            bg = 534
            bb = 131


            # Operaciones para el filtro
            # Multiplicar
            # Para el rojo
            rojo1 = (r * rr)
            rojo2 = (g * rg)
            rojo3 = (b * rb)

            # Para el verde
            verde1 = r * gr
            verde2 = g * gg
            verde3 = b * gb

            # Para el azul
            azul1 = r * br
            azul2 = g * bg
            azul3 = b * bb

            # Dividir
            # Para el rojo
            rojo1 /= 1000
            rojo2 /= 1000
            rojo3 /= 1000

            # Para el verde
            verde1 /= 1000
            verde2 /= 1000
            verde3 /= 1000

            # Para el azul
            azul1 /= 1000
            azul2 /= 1000
            azul3 /= 1000


            #Arreglar lo del int (usar la otra función de división)
            outputRed = int(rojo1 + rojo2 + rojo3)

            outputGreen = int(verde1 + verde2 + verde3)


            outputBlue = int(azul1 + azul2 + azul3)

            # Asegurar que los valores no excedan 255
            if outputRed > 255:
                outputRed = 255

            if outputGreen > 255:
                outputGreen = 255

            if outputBlue > 255:
                outputBlue = 255

            # Guardar los nuevos pixeles en otra lista
            newPixelList.append((outputRed, outputGreen, outputBlue))


            # Edita lo pixeles originales
            pixels[px, py] = (outputRed, outputGreen, outputBlue)
    return img_sepia

img = Image.open("pandaR.jpg") # Variable para guardar el path de la imagen
img.show() # Muestra la imagen

sepia_img = sepia_filter(img) #Llamada a la función
sepia_img.show()