FactoryGirl.define do
  factory :item do
    handle { Faker::Internet.unique.password(17, 17) }
    end_service_id { (EndService.all.count > 0 ? EndService.all.sort_by{ rand }.first : FactoryGirl.create(:end_service)).id }
  end
end
