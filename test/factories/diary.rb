FactoryBot.define do

  factory :diary do
    user
  end

  factory :diary_entry do
    diary
    title { Faker::Lorem.sentence(word_count: 3) }
    entry_type { DiaryEntry::ENTRY_TYPES.sample }
  end

  factory :day do
    diary
    sequence(:date) { |n| DateTime.current - 1.year + n.day }
  end

  factory :day_entry do
    day
    diary_entry
  end

end