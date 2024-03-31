unless Rails.env.production?
  namespace :dev do
    desc "Destroy, create, migrate, and seed database"
    task reset: [
           :environment,
           "db:drop",
           "db:create",
           "db:migrate",
           "db:seed",
           "dev:sample_data",
         ] do
      puts "done resetting"
    end

    desc "Add sample data"
    task sample_data: :environment do
      timezones = ActiveSupport::TimeZone.all.map(&:name)
    
      # Create users
      names = ["Sally Sanders", "Jordan Childs", "Alexander Huynh", "Anna Huynh", "Christina Nguyen"]
      users = names.map do |full_name|
        first_name = full_name.split(" ").first
        User.create!(
          email: "#{first_name.downcase}@example.com",
          username: "#{first_name.downcase}#{rand(100..999)}",
          name: full_name, # Use the full name here
          password: "password",
          timezone: timezones.sample, # Assuming `timezones` is defined elsewhere
        )
      end
    
      # Create groups
      groups = 5.times.map do
        Group.create!(
          name: Faker::Hobby.activity,
          description: Faker::Lorem.sentence(word_count: 100),
        )
      end
    
      # Create memberships
      users.each do |user|
        user_groups = groups.sample(rand(1..3)) # Each user joins 1 to 3 groups randomly
        user_groups.each do |group|
          Membership.create!(
            user: user,
            group: group,
          )
        end
      end
    
      # Update group membership counts
      Group.find_each do |group|
        group.update(memberships_count: group.memberships.count)
      end
    
    
      # Create events for each calendar with realistic details
      Calendar.all.each do |calendar|
        rand(1..3).times do # Each calendar gets 1 to 3 events
          # Realistic start time and duration
          start_day = Faker::Date.between(from: Date.today.beginning_of_month, to: Date.today.end_of_month)
          start_hour = rand(8..20) # Assuming events happen between 8 AM and 8 PM
          start_minute = [0, 15, 30, 45].sample
          start_time = DateTime.new(start_day.year, start_day.month, start_day.day, start_hour, start_minute, 0)
          duration = [30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210, 225, 240].sample
          end_time = start_time + duration.minutes
    
          # Varied event themes
          event_themes = [
            { name: "Team Meeting", description: "Discuss project updates and tasks" },
            { name: "Workshop: Personal Development", description: "A workshop focused on skill-building and personal growth" },
            { name: "Client Call", description: "Strategy meeting with a key client" },
            { name: "Book Club", description: "Discussion on this month's selected book" },
            { name: "Yoga Class", description: "Evening session to relax and recharge" },
            { name: "Tech Talk: Industry Trends", description: "Exploring the latest trends in technology" }
          ]
          event_theme = event_themes.sample
    
          calendar.events.create!(
            name: event_theme[:name],
            description: event_theme[:description],
            location: Faker::Address.city,
            start_time: start_time,
            end_time: end_time,
            timezone: timezones.sample,
          )
        end
      end
    end
  end
end
