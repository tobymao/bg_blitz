Base = Class.new Sequel::Model

class Base
  def pp_created_at
    created_at.strftime('%B %-d, %Y')
  end
end
