def arm_to_intel_hex(arm_hex, address):
    # Convertir instrucción ARM de big-endian a little-endian
    instruction_big_endian = bytes.fromhex(arm_hex)
    data_hex = instruction_big_endian.hex().upper()

    # Longitud de los datos: 4 bytes (por ser una instrucción ARM de 32 bits)
    length = "04"
    
    # Tipo de registro: 00 (indica datos)
    record_type = "00"
    
    # Concatenar todos los elementos del registro sin checksum
    record = f"{length}{address:04X}{record_type}{data_hex}"

    # Calcular el checksum
    checksum = (-(sum(bytes.fromhex(record)) & 0xFF)) & 0xFF

    # Formato final del registro en Intel HEX
    intel_hex = f":{record}{checksum:02X}"
    return intel_hex

def convert_file_to_intel_hex(input_filename, output_filename):
    # Leer instrucciones desde el archivo
    with open(input_filename, 'r') as infile:
        lines = infile.readlines()
    
    # Convertir cada instrucción y escribir en el archivo de salida
    with open(output_filename, 'w') as outfile:
        address = 0x0000  # Dirección inicial
        for line in lines:
            arm_hex = line.strip()  # Remover espacios en blanco y saltos de línea
            if arm_hex:  # Si la línea no está vacía
                intel_hex = arm_to_intel_hex(arm_hex, address)
                outfile.write(intel_hex + '\n')
                address += 1  # Incrementar la dirección en 4 bytes para la siguiente instrucción
        outfile.write(":00000001FF\n")

# Ejecutar la conversión
input_filename = "./instrucciones/instruccionesCompletas.txt"
output_filename = "./instrucciones/memoriaCompletas.txt"
convert_file_to_intel_hex(input_filename, output_filename)
print(f"Conversion complete. Output saved to {output_filename}.")
