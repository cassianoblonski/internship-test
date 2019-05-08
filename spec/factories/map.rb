FactoryBot.define do
  factory :map do
    name {"Halan Map"}
    point_connections { {A: {B:10, C:20}, B:{D:15, E:50}, C:{D:30}, D:{E:30}} }
  end
end
