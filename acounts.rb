require 'mysql'
module Collection
  include Enumerable
  def find(id)

  end
  def delete(id)

  end
  def each(o=nil)

  end
  def update(id)

  end
  def add(o)

  end
end

module AccountUtil
  def self.parse_account(h)
    acc=Account.new
    acc.id=h[0].to_i
    acc.name=h[1]
    acc.balance=h[2].to_f
    acc.type=h[3]
    acc
  end

end

module DataSourceUtil
  def self.create_database(conn,name)
     sql="CREATE DATABASE "+name
    conn.query sql
  end
  def self.select_database(conn,name)
     conn.query "USE "+name
  end
  def self.database_exists?(conn,name)

  end
  def self.drop_database(conn,name)
     sql "DROP DATABASE "+name
    conn.query sql
  end
  def self.create_table(conn,name,fields)
     sql="CREATE TABLE "
  end
  def self.connection(hostname,user,password)
    Mysql.new hostname,user,password
  end
  def close(conn)
    conn.close if conn
  end
end



class Account
  attr_accessor :id,:name,:balance,:type
  def to_s
    "#{id},#{name},#{balance},#{type}"
  end
end


class Accounts
  include Collection
  attr_accessor :connection

  def find(id)
    sql="SELECT ACCOUNT_ID,ACCOUNT_NAME,ACCOUNT_BALANCE,ACCOUNT_TYPE FROM ACCOUNTS WHERE ACCOUNT_ID='#{id}'"
    rs=@connection.query sql
    row=rs.fetch_row
    AccountUtil.parse_account(row) if row
  end
  def delete(id)
      sql="DELETE FROM  ACCOUNTS WHERE ACCOUNT_ID=?"
      prepared=@connection.prepare sql
      prepared.execute id
  end
  def add(acc)
    sql="INSERT INTO ACCOUNTS(ACCOUNT_ID,ACCOUNT_NAME,ACCOUNT_BALANCE,ACCOUNT_TYPE)VALUES(?,?,?,?);"
    prepared=@connection.prepare sql
    prepared.execute acc.id,acc.name,acc.balance,acc.type
  end
  def fetch(sql=nil)
    accs=[]
    sql="SELECT ACCOUNT_ID,ACCOUNT_NAME,ACCOUNT_BALANCE,ACCOUNT_TYPE FROM ACCOUNTS" if not sql
    rs=@connection.query sql
    rs.each do |row|
      accs<<AccountUtil.parse_account(row)

    end
    accs

  end
  def each(sql=nil)
    fetch(sql).each do |a|
      yield a if block_given?
    end




  end
  def update(acc)
    sql ="UPDATE ACCOUNTS SET ACCOUNT_NAME=?,ACCOUNT_BALANCE=?"
    prepared=@connection.prepare sql
    prepared.execute acc.name,acc.balance
  end


  def close
    @connection.close if @connection
  end
  def connected?
    if @connection then true else false end
  end

end






