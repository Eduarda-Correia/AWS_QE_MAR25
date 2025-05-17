class Calculadora:
    #Funcao de soma
    def somar(self, a, b): return a + b

    #Funcao de subtração
    def subtrair(self, a, b): return a - b

    #Funcao de multiplicao
    def multiplicar(self, a, b): return a * b

    #Funcao de divisão
    def dividir(self, a, b):
        if b == 0:
            raise ValueError("Divisão por zero")
        return a / b
    
    #Funcao de potenciacao
    def potencia(self, a, b): return a ** b
    
    #Funcao de modulo
    def modulo(self, a, b): return a % b