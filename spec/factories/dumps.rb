FactoryBot.define do
  factory :dump do
    goods        {"洋服"}
    price        {"5000"}
    image        {"fashion.jpg"}
    description  {"同じような服を何枚も持っているから"}
    user_id      {1}
  end
end