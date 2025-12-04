# db/seeds.rb

# Create roles
admin_role = Role.find_or_create_by(name: 'admin')
member_role = Role.find_or_create_by(name: 'member')

# Create admin user
admin = User.create!(
  email: 'admin@church.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Admin',
  last_name: 'User',
  age: 30
)
admin.add_role(:admin)

puts "Created admin user: admin@church.com / password123"

# Create branches
main_branch = Branch.create!(name: 'Main Church', address: 'Main Street, City', status: 'Active')
cainta_branch = Branch.create!(name: 'Cainta Church', address: 'Cainta, Rizal', status: 'Active')
carissa_branch = Branch.create!(name: 'Carissa 2 Church', address: 'Carissa Village', status: 'Active')

puts "Created #{Branch.count} branches"

# Create departments for main branch
music_dept = Department.create!(name: 'Music Department', branch: main_branch, description: 'Handles worship and music')
youth_dept = Department.create!(name: 'Youth Department', branch: main_branch, description: 'Youth ministry')
elders_dept = Department.create!(name: 'Elders', branch: main_branch, description: 'Church elders')
pastors_dept = Department.create!(name: 'Pastors', branch: main_branch, description: 'Church pastors')

puts "Created #{Department.count} departments"

# Create positions for Music Department
Position.create!(name: 'Music Director', department: music_dept, unique: true)
Position.create!(name: 'Lead Pianist', department: music_dept, unique: true)
Position.create!(name: 'Auxiliary Pianist', department: music_dept, unique: false)
Position.create!(name: 'Lead Guitarist', department: music_dept, unique: true)
Position.create!(name: 'Acoustic Guitarist', department: music_dept, unique: false)
Position.create!(name: 'Bassist', department: music_dept, unique: false)
Position.create!(name: 'Drummer', department: music_dept, unique: false)
Position.create!(name: 'Vocalist', department: music_dept, unique: false)

# Create positions for Youth Department
Position.create!(name: 'Youth President', department: youth_dept, unique: true)
Position.create!(name: 'Youth Leader', department: youth_dept, unique: false)
Position.create!(name: 'Youth Member', department: youth_dept, unique: false)

# Create positions for Pastors
Position.create!(name: 'Superintendent Pastor', department: pastors_dept, unique: true)
Position.create!(name: 'Assistant Pastor', department: pastors_dept, unique: false)

# Create positions for Elders
Position.create!(name: 'Elder', department: elders_dept, unique: false)

puts "Created #{Position.count} positions"

# Create a sample member
member = User.create!(
  email: 'member@church.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'John',
  last_name: 'Doe',
  age: 25,
  phone_number: '09171234567',
  branch: main_branch,
  department: music_dept,
  baptismal_date: Date.today - 1.year
)

puts "Created sample member: member@church.com / password123"
puts "✅ Seed data created successfully!"