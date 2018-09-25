class DineroPresenter < SimpleDelegator
  def diez_centavos
    super * 0.1
  end

  def veinte_centavos
    super * 0.2
  end

  def cincuenta_centavos
    super * 0.5
  end

  def un_peso
    super * 1.0
  end

  def dos_pesos
    super * 2.0
  end

  def cinco_pesos
    super * 5.0
  end

  def diez_pesos
    super * 10.0
  end

  def veinte_pesos
    super * 20.0
  end

  def veinte_m_pesos
    super * 20.0
  end

  def cincuenta_pesos
    super * 50.0
  end

  def cien_pesos
    super * 100.0
  end

  def doscientos_pesos
    super * 200.0
  end

  def quinientos_pesos
    super * 500.0
  end

  def mil_pesos
    super * 1000.0
  end

  def dos_mil_pesos
    super * 2000.0
  end

  def total
    diez_centavos + veinte_centavos + cincuenta_centavos +
      un_peso + dos_pesos + cinco_pesos + diez_pesos +
      veinte_pesos + veinte_m_pesos + cincuenta_pesos + cien_pesos +
      doscientos_pesos + quinientos_pesos + mil_pesos + dos_mil_pesos
  end
end
