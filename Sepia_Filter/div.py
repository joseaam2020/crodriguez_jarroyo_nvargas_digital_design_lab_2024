from mult import multiplicar



def division(dividendo, divisor):
    precision = 10
    cociente = 0
    residuo = dividendo

    # Parte entera
    while residuo >= divisor:
        residuo -= divisor
        cociente += 1

    # Parte decimal
    decimal = 0
    factor = 1  # Desplazamiento de la coma decimal
    for _ in range(precision):
        residuo = multiplicar(residuo, 10)  # Simula mover la coma decimal
        digit = 0
        while residuo >= divisor:
            residuo -= divisor
            digit += 1
        factor = multiplicar(factor, 10) # Mantiene el lugar decimal
        decimal += digit / factor  # Añade el valor decimal correspondiente

    return cociente + decimal


#resultado = division(15, 12)
#print(resultado)

'''
# Versión que devuelve el número entero

def division(dividendo, divisor):
    cociente = 0
    residuo = dividendo
    
    # Mientras el residuo sea mayor o igual al divisor
    while residuo >= divisor:
        residuo -= divisor  # Restamos el divisor del residuo
        cociente += 1  # Incrementamos el cociente en cada iteración
    return cociente, residuo  # El cociente es el resultado de la división, y el residuo es lo que sobra
    '''