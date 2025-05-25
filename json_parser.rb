require "json"
file_path = "users.json"
file_content = nil

begin
    File.open(file_path, 'r') do |file|
        file_content = file.read
    end
rescue SystemCallError => e
    puts "Error while reading '#{}': #{e.message}"
    exit
end

users_data = nil
begin
    users_data = JSON.parse(file_content)
rescue JSON::ParserError => e
    puts "Error while parsing JSON: #{e.mesage}"
    puts "Check file format of '#{file_path}'"
    exit
end

puts "\n--- Users info ---"
if users_data.is_a?(Array) && !users_data.empty?
    users_data.each_with_index do |user, index|
        name = user['name'] || '--'
        age = user['age'] || '--'
        city = user['city'] || '--'

        puts "| User ##{index + 1}:"
        puts "|  Name: #{name}"
        puts "|  Age:  #{age}"
        puts "|  City: #{city}"
        puts "-" * 20
    end
else
    puts "Users data not found, or bad format"
end

if users_data.is_a?(Array) && !users_data.empty?
    total_age = 0
    valid_age_count = 0

    users_data.each do |user|
        if user['age'].is_a?(Numeric)
            total_age += user['age']
            valid_age_count += 1
        end
    end

    if valid_age_count > 0
        avarage_age = total_age.to_f / valid_age_count

        puts "--- Stats ---"
        puts "Avarage age of a user is: #{avarage_age.round(2)}"
    else
        puts "\nCan't calculate avarage age (age data is missing or invalid)"
    end
end