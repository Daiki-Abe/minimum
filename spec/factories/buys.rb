FactoryBot.define do
  factory :buy do
    goods        { '漫画' }
    price        { '500' }
    image        { 'manga.jpg' }
    description  { '漫画は新しい価値観を提供してくれるから' }
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
    after(:build) do |buy|
      tag = create(:tag)
      buy.buy_tags << build(:buy_tag, tag: tag, buy: buy)
    end
  end
end
