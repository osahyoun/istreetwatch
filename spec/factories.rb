FactoryGirl.define do
  factory :report do
    informant_name 'Name'
    informant_email 'email@example.com'
    informant_tel '12345'
    informant_role 'Role'
    informant_permission true
    type_incident 'Type of incident'
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
    type_location "Type of location"
    type_location_other ''
    reported_to_police 'No'
  end

  factory :pledge do
    name 'Name'
    email 'email@example.com'
  end
end