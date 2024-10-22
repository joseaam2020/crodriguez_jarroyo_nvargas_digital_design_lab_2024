'''Librería para el manejo de la imagen
Para el manejo de la imagen y los pixeles de la misma se puede usar una libería
ya que esto se va a hacer de otra forma (ya conocida) en Cpulator
'''

# Arreglo para guardar el RGB
from PIL import Image


img = Image.open("pandaR.jpg") # Variable para guardar el path de la imagen
img.show() # Muestra la imagen

# (x, y) position
xy = (50, 100)

# Get pixel value
pixel_value = img.getpixel(xy)
print(pixel_value)