puts 'Start inserting seed "post" ...'

3.times do
    User.find_each do |user|
        user.posts.create({
            body: Faker::Hacker.say_something_smart,
            user_id: user.id
        })
        puts "\"#{user.name}\" posted something!"
    end
end