from src.calculadora import Calculadora
import pytest

def test_soma():
    calc = Calculadora()
    assert calc.somar(10, 10) == 20

def test_subtracao():
    calc = Calculadora()
    assert calc.subtrair(10, 10) == 0

def test_multiplicacao():
    calc = Calculadora()
    assert calc.multiplicar(10, 10) == 100

def test_divisao():
    calc = Calculadora()
    assert calc.dividir(10, 10) == 1
    
def test_divisao_por_zero():
    calc = Calculadora()
    with pytest.raises(ValueError):
        calc.dividir(10, 0)

def test_potencia():
    calc = Calculadora()
    assert calc.potencia(10, 2) == 100

def test_modulo():
    calc = Calculadora()
    assert calc.modulo(10, 2) == 0