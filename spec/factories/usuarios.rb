FactoryBot.define do
  factory :usuario do
    nombre "Pedro"
    username Sequence(lambda n: 'pedro%s' % n)
    activo true
    rol 0
  end
end
