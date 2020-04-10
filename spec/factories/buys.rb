FactoryBot.define do
  factory :buy do
    goods        {"漫画"}
    price        {"500"}
    image        {"manga.jpg"}
    description  {"漫画は新しい価値観を提供してくれるから"}
    user_id      {1}
  end
end