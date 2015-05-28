class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :visualization_paths
  PHI_ROLE = {:not_authorized=>0, :authorized=>1}
end
