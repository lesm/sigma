ActiveSupport::Inflector.inflections do |inflect|
  remplazos = {
    'a' => 'as',
    'e' => 'es',
    'i' => 'is',
    'o' => 'os',
    'u' => 'us',
    'd' => 'des',
    'j' => 'jes',
    'l' => 'les',
    'n' => 'nes',
    'r' => 'res',
    'y' => 'yes',
    'z' => 'ces',
  }

  inflect.plural(/(a)(?=$)/, 'as')
  inflect.plural(/(e)(?=$)/, 'es')
  inflect.plural(/(i)(?=$)/, 'is')
  inflect.plural(/(o)(?=$)/, 'os')
  inflect.plural(/(u)(?=$)/, 'us')
  inflect.plural(/(d)(?=$)/, 'des')
  inflect.plural(/(j)(?=$)/, 'jes')
  inflect.plural(/(l)(?=$)/, 'les')
  inflect.plural(/(n)(?=$)/, 'nes')
  inflect.plural(/(r)(?=$)/, 'res')
  inflect.plural(/(y)(?=$)/, 'yes')
  inflect.plural(/(z)(?=$)/, 'ces')


  inflect.singular(/((?<singular>ia)|(?<singular>ta)|(?<singular>[aeiou][rldyjn])es|(?<singular>[bcdfgpt][lr]e|[aeiou])s)(?=$)/, '\\k<singular>')

  # Para singularizar palabras con 'ces', como 'maices'
  inflect.singular(/ces$/, 'z')

  #-----------------------------------------------------------------------------

  # Las palabras en singular que terminan con s son un caso especial, ya que
  # rails infiere que ya están en plural, lo cual es falso. Por ejemplo, pais.
  # Es necesario indicar que el plural de pais es paises y viceversa. Esto se
  # puede hacer declarándolo como irregular:
  inflect.irregular 'pais', 'paises'
  # Pero es necesario agregar otra regla. Pais termina en s, pero ya está en
  # singular, por lo que hay que indicarle a rails que no elimine la s final.
  inflect.singular /(pais)(?=[A-Z]|_|$)/, '\1'

  # el mismo caso aplica para 'mes'
  inflect.irregular 'mes', 'meses'
  inflect.singular /(mes)(?=[A-Z]|_|$)/, '\1'

  # Ejemplos cuyo plural y singular sea el mismo
  inflect.uncountable %w( campus lunes martes miercoles jueves viernes )
end
