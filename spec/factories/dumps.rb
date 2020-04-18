FactoryBot.define do
  factory :dump do
    goods        { '洋服' }
    price        { '5000' }
    image        { 'fashion.jpg' }
    description  { '同じような服を何枚も持っているから' }
    user
    after(:build) do |dump|
      tag = create(:tag)
      dump.dump_tags << build(:dump_tag, tag: tag, dump: dump)
    end
  end
end
