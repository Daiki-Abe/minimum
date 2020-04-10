FactoryBot.define do
  factory :buy do
    goods        {"漫画"}
    price        {"500"}
    image        {"manga.jpeg"}
    description  {"漫画は世界を変えるから"}
    user_id      {"1"}
  end
end