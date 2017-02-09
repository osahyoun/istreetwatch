FactoryGirl.define do
  factory :report do
    informant_name 'Name'
    informant_email 'email@example.com'
    informant_tel '12345'
    informant_role 'Something that happened to me'
    informant_permission true
    type_incident 'Verbal abuse / insults'
    type_incident_other ''
    description 'Description'
    support 'Support'
    date Time.zone.now
    street 'Street'
    town 'Town'
    postcode 'W1'
    region 'Region'
    lng 50.8225
    lat 0.1372
    house 'House'
    country 'Country'
    type_location "Shops"
    type_location_other ''
    reported_to_police 'No'
    approved false
  end

  factory :pledge do
    name 'Name'
    email 'email@example.com'
  end
end