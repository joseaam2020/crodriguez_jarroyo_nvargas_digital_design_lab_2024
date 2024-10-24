'''Librería para el manejo de la imagen
Para el manejo de la imagen y los pixeles de la misma se puede usar una libería
ya que esto se va a hacer de otra forma (ya conocida) en Cpulator
'''





from PIL import Image
from mult import multiplicar
from div import division

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

            #Arreglar lo del int (usar la otra función de división)
            outputRed = int(division(multiplicar(r,393), 1000) +
                            division(multiplicar(g,769), 1000) +
                            division(multiplicar(b,189), 1000))

            outputGreen = int(division(multiplicar(r, 349), 1000) +
                            division(multiplicar(g, 686), 1000) +
                            division(multiplicar(b, 168), 1000))

            outputBlue = int(division(multiplicar(r, 272), 1000) +
                            division(multiplicar(g, 534), 1000) +
                            division(multiplicar(b, 131), 1000))

            # Asegurar que los valores no excedan 255
            if outputRed > 255:
                outputRed = 255

            if outputGreen > 255:
                outputGreen = 255

            if outputBlue > 255:
                outputBlue = 255

            # Guardar los nuevos pixeles en otra lista lista
            newPixelList.append((outputRed, outputGreen, outputBlue))


            # Edita lo pixeles originales
            pixels[px, py] = (outputRed, outputGreen, outputBlue)
    return img_sepia

img = Image.open("pandaR.jpg") # Variable para guardar el path de la imagen
img.show() # Muestra la imagen

sepia_img = sepia_filter(img) #Llamada a la función
sepia_img.show()