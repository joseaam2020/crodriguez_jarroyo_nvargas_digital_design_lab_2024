from PIL import Image

# Abrir la imagen
image = Image.open("./imagen/computer.jpg")
image = image.convert("RGB")  # Asegurarse de que está en modo RGB

# Obtener las dimensiones de la imagen
width, height = image.size

# Inicializar el archivo .hex
with open("./imagen/imagen_32bits.hex", "w") as hex_file:
    for y in range(height):
        for x in range(width):
            # Obtener valores RGB del píxel
            r, g, b = image.getpixel((x, y))
            a = 0x00  # Canal alfa añadido (por ejemplo, completamente opaco)

            # Formatear los datos en hexadecimal (4 bytes en total) y calcular el checksum
            data = f"{a:02X}{r:02X}{g:02X}{b:02X}"  # Datos RGBA en formato hex
            data_length = 4  # Longitud en bytes (1 byte para cada canal RGBA)
            address = (y * width + x)+4  # Dirección única para cada píxel, ahora ajustada para 32 bits
            record_type = "00"  # Tipo de registro (00 para datos)

            # Línea en formato Intel HEX
            line = f":{data_length:02X}{address:04X}{record_type}{data}"

            # Calcular el checksum
            byte_values = [int(line[i:i+2], 16) for i in range(1, len(line), 2)]
            checksum = (-sum(byte_values)) & 0xFF  # Complemento a 2
            line += f"{checksum:02X}"

            # Escribir la línea en el archivo
            hex_file.write(line + "\n")

    # Agregar el registro de fin de archivo
    hex_file.write(":00000001FF\n")
