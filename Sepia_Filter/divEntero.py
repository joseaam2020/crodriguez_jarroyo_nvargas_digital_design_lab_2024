def division(dividendo, divisor):
    cociente = 0
    residuo = dividendo

    # Mientras el residuo sea mayor o igual al divisor
    while residuo >= divisor:
        residuo -= divisor  # Restamos el divisor del residuo
        cociente += 1  # Incrementamos el cociente en cada iteración
    return cociente, residuo  # El cociente es el resultado de la división, y el residuo es lo que sobra