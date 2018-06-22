require 'yaml'

data = YAML.load_file('public/config_db.yml')
if User.exists?
  puts 'Database has all params'
else
  data['users'].each do |user_key, value|
    User.create!(
      id: user_key,
      name: value['name']
    )
    last_id = User.last.id
    sql = "ALTER SEQUENCE users_id_seq RESTART WITH #{last_id}"
    ActiveRecord::Base.connection.execute(sql)

    data['accounts'].each_value do |val|
      if user_key == val['user_id']
        Account.create(
          user_id: user_key,
          amount: val['balance'],
          currency: val['currency']
        )
      end
    end
  end
end
