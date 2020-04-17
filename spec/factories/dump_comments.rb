FactoryBot.define do
  factory :dump_comment do
    text        {"素晴らしいです"}
    user
    dump
  end
end