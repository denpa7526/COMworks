namespace :admin do
  desc "Create initial admin user"
  task create_initial: :environment do
    admin = AdminUser.new(
      last_name: '管理者'
      first_name: 'アドミン'
      username: '社内管理者'
      company: '管理株式会社'
      phone_number: '1234567890'
      email: 'admin@example.com',
      password: 'secure_admin_password',
      password_confirmation: 'secure_admin_password'
    )
    admin.save(validate: false)
    puts "Initial admin user created with email: admin@example.com"
  end
end