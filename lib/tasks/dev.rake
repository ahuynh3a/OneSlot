unless Rails.env.production?
  namespace :dev do
    desc "Destroy, create, migrate, and seed database"
    task reset: [
     :environment, 
     "db:drop", 
     "db:create", 
     "db:migrate", 
     "db:seed",
     "dev:sample_data"] do
      puts "done resetting"
   end

   desc "Add sample data"
   task sample_data: :environment do

  timezones = ActiveSupport::TimeZone.all.map(&:name)

    #create users

    names = ["sally", "jordan", "alexander", "anna", "christina"]
    names.each do |name| 
      user = User.create!(
        email: "#{name}@example.com",
        username: name,
        name: name,
        password: "password",
        timezone: timezones.sample
      )
    end

    #create calendars
    5.times do 
      Calendar.create(
        title: Faker::Book.title,
        description: Faker::Movies::HarryPotter.quote,
        owner: User.all.sample
      )
    end


    #create events
    

    Calendar.all.each do |calendar|
    rand(1..3).times do
     calendar.events.create(
       title: Faker::Restaurant.name,
       description: Faker::Restaurant.review,
       location: Faker::Address.city,
       start_date_time: Faker::Date.between(from: '2024-02-01', to: '2024-02-25'),
        end_date_time: Faker::Date.between(from: '2024-03-01', to: '2024-03-28'),
        timezone: timezones.sample
       )
     end
    end


    #create groups
    5.times do
      Group.create(
        name: Faker::Hobby.activity,
        description: Faker::Lorem.sentence(word_count: 100),
        memberships_count: Faker::Number.between(from: 1, to: 5)
      )
    end

    
    #create memberships
    desired_memberships_per_group = 3
    total_memberships_to_create = Group.count * desired_memberships_per_group

    total_memberships_to_create.times do
    user = User.order('RANDOM()').first
    group = Group.order('RANDOM()').first

    next if Membership.exists?(user_id: user.id, group_id: group.id)

    Membership.create(
     user_id: user.id,
     group_id: group.id
  )
end

    Group.find_each do |group|
    group.update(memberships_count: group.memberships.count)
    end
  end
  end
end
