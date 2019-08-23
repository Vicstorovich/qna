if Admin.count.zero?
  puts "Seeding Admins"
  Admin.create!(email: "admin@admin.ru", password: "1111111")
end
