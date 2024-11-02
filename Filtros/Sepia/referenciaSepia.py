from PIL import Image

def sepia(img):
    width, height = img.size

    pixels = img.load() # create the pixel map

    for py in range(height):
     for px in range(width):
         r, g, b = img.getpixel((px, py))

         tr = int(0.393 * r + 0.769 * g + 0.189 * b)
         tg = int(0.349 * r + 0.686 * g + 0.168 * b)
         tb = int(0.272 * r + 0.534 * g + 0.131 * b)

         if tr > 255:
             tr = 255

         if tg > 255:
             tg = 255

         if tb > 255:
             tb = 255

         pixels[px, py] = (tr,tg,tb)

    return img

img = Image.open("pandaR.jpg") # Variable para guardar el path de la imagen
img.show() # Muestra la imagen

sepia_img = sepia(img) #Llamada a la función
sepia_img.show()