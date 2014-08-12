require 'puppet/provider/mongodb'

Puppet::Type.type(:mongodb_user).provide :mongodb, :parent => Puppet::Provider::Mongodb do

  desc 'Manage users for a MongoDB database.'

  defaultfor :kernel => 'Linux'

  def create
    password_hash = create_password_hash('puppet-mongodb', @resource[:password])
    data = {
        :user => @resource[:name],
        :pwd => @resource[:password],
        :roles => @resource[:roles],
        :customData => {:puppetPasswordHash => password_hash}
    }
    mongo_command("db.createUser(#{JSON.dump data})", find_master, @resource[:database])
  end

  def destroy
    mongo_command("db.dropUser(#{JSON.dump @resource[:name]})", find_master, @resource[:database])
  end

  def exists?
    block_until_command
    !db_find_user.nil?
  end

  def password
    password_hash_should = create_password_hash('puppet-mongodb', @resource[:password])
    password_hash_is = db_find_user['customData']['puppetPasswordHash']
    if password_hash_is == password_hash_should
      @resource[:password]
    else
      @resource[:password] + 'change_me'
    end
  end

  def password=(value)
    password_hash = create_password_hash('puppet-mongodb', value)
    db_update_user({:pwd => value, :customData => {:puppetPasswordHash => password_hash}})
  end

  def roles
    db_find_user['roles']
  end

  def roles=(value)
    db_update_user({:roles => value})
  end

  private

  def find_master
    host = @resource[:router]
    ismaster_info = db_ismaster_info(host)
    unless ismaster_info['ismaster']
      unless ismaster_info.has_key?('primary')
        raise Puppet::Error, "Cannot detect primary on `#{host}` to create user `#{@resource[:name]}`."
      end
      host = ismaster_info['primary']
    end
    host
  end

  def db_ismaster_info(host)
    mongo_command_json('db.isMaster()', host)
  end

  def db_find_user
    mongo_command_json("db.getUser(\"#{@resource[:name]}\")", find_master, @resource[:database])
  end

  def db_update_user(data)
    mongo_command("db.updateUser(#{JSON.dump @resource[:name]}, #{JSON.dump data})", find_master, @resource[:database])
  end

  def create_password_hash(password, salt)
    Digest::MD5.hexdigest("#{salt}:mongo:#{password}")
  end

end
