class VisualizationPath < ActiveRecord::Base
  has_many :visualizations
  belongs_to :user
end
